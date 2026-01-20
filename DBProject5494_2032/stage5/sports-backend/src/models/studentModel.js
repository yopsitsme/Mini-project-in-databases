// models/studentModel.js
const pool = require("../config/database");

const studentModel = {
  // Get student schedule
  async getStudentSchedule(studentId) {
    const result = await pool.query("SELECT * FROM get_student_courses($1)", [
      studentId,
    ]);
    return result.rows;
  },

  // Get all students
  async getAllStudents() {
    const result = await pool.query(`
      SELECT s.studentid, p.first_name, p.last_name, p.email, p.phone, 
             p.birth_date, s.addres, s.parentid
      FROM student s
      JOIN person p ON s.studentid = p.personid
      ORDER BY p.first_name, p.last_name
    `);
    return result.rows;
  },

  // Create new student
  async createStudent(client, studentData) {
    const { firstName, lastName, email, phone, birthDate, address, parentId } =
      studentData;

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

    // Insert into student table
    const studentResult = await client.query(
      `INSERT INTO student (studentid, addres, parentid)
       VALUES ($1, $2, $3)
       RETURNING studentid`,
      [newId, address || null, parentId || null],
    );

    return studentResult.rows[0];
  },

  // Enroll student in groups
  async enrollStudentBulk(client, studentId, groupIds) {
    const result = await client.query(
      "CALL enroll_student_bulk($1, $2, NULL)",
      [studentId, groupIds],
    );
    return result;
  },
};

module.exports = studentModel;
