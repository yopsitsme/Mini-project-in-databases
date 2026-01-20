// models/teacherModel.js
const pool = require("../config/database");

const teacherModel = {
  // Get teacher workload
  async getTeacherWorkload(teacherId) {
    const result = await pool.query(
      "SELECT calculate_teacher_workload($1) as result",
      [teacherId],
    );
    return result.rows;
  },

  // Get teacher schedule
  async getTeacherSchedule(teacherId) {
    const result = await pool.query("SELECT * FROM get_teacher_schedule($1)", [
      teacherId,
    ]);
    return result.rows;
  },

  // Get all teachers
  async getAllTeachers() {
    const result = await pool.query(`
      SELECT t.teacherid, p.first_name, p.last_name, p.email, p.phone,
             p.birth_date, t.salary, t.hire_date, t.specialty
      FROM teacher t
      JOIN person p ON t.teacherid = p.personid
      ORDER BY p.first_name, p.last_name
    `);
    return result.rows;
  },

  // Create new teacher
  async createTeacher(client, teacherData) {
    const {
      firstName,
      lastName,
      email,
      phone,
      birthDate,
      salary,
      hireDate,
      specialty,
    } = teacherData;

    // Get next person ID
    const idResult = await client.query(
      "SELECT COALESCE(MAX(personid), 0) + 1 as next_id FROM person",
    );
    const newId = idResult.rows[0].next_id;

    // Insert into person table
    const personResult = await client.query(
      `INSERT INTO person (personid, first_name, last_name, email, phone, birth_date)
       VALUES ($1, $2, $3, $4, $5, $6)
       RETURNING personid`,
      [newId, firstName, lastName, email || null, phone || null, birthDate],
    );

    // Insert into teacher table
    const teacherResult = await client.query(
      `INSERT INTO teacher (teacherid, salary, hire_date, specialty)
       VALUES ($1, $2, $3, $4)
       RETURNING teacherid`,
      [newId, salary, hireDate, specialty || null],
    );

    return teacherResult.rows[0];
  },
};

module.exports = teacherModel;
