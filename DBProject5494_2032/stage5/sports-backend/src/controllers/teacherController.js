// controllers/teacherController.js
const teacherModel = require("../models/teacherModel");

const teacherController = {
  // Get teacher workload
  async getTeacherWorkload(req, res) {
    const { teacherId } = req.params;

    try {
      const result = await teacherModel.getTeacherWorkload(teacherId);

      if (result.length > 0) {
        res.json({ workload: result[0].result });
      } else {
        res.status(404).json({ error: "Teacher not found" });
      }
    } catch (error) {
      console.error("Error fetching teacher workload:", error);
      res.status(500).json({ error: error.message });
    }
  },

  // Get teacher schedule
  async getTeacherSchedule(req, res) {
    const { teacherId } = req.params;
    const dayMapping = {
      Sunday: "ראשון",
      Monday: "שני",
      Tuesday: "שלישי",
      Wednesday: "רביעי",
      Thursday: "חמישי",
      Friday: "שישי",
      Saturday: "שבת",
    };

    try {
      const result = await teacherModel.getTeacherSchedule(teacherId);

      // Organize by day of week (Hebrew names)
      const schedule = {
        ראשון: [],
        שני: [],
        שלישי: [],
        רביעי: [],
        חמישי: [],
        שישי: [],
        שבת: [],
      };

      result.forEach((course) => {
        const dayHebrew = dayMapping[course.day_of_week] || course.day_of_week;
        schedule[dayHebrew].push({
          className: course.class_name,
          level: course.level,
          time: course.time,
          location: course.location,
          groupId: course.groupid,
        });
      });

      res.json({ schedule });
    } catch (error) {
      console.error("Error fetching teacher schedule:", error);
      res.status(500).json({ error: error.message });
    }
  },

  // Get all teachers
  async getAllTeachers(req, res) {
    try {
      const result = await teacherModel.getAllTeachers();
      res.json(result);
    } catch (error) {
      console.error("Error fetching teachers:", error);
      res.status(500).json({ error: error.message });
    }
  },

  // Create new teacher
  async createTeacher(req, res) {
    const {
      firstName,
      lastName,
      email,
      phone,
      birthDate,
      salary,
      hireDate,
      specialty,
    } = req.body;

    // Validation
    if (!firstName || !lastName || !birthDate || !salary || !hireDate) {
      return res.status(400).json({
        error:
          "Missing required fields: firstName, lastName, birthDate, salary, and hireDate are required",
      });
    }

    const pool = require("../config/database");
    const client = await pool.connect();

    try {
      await client.query("BEGIN");

      const teacherData = {
        firstName,
        lastName,
        email,
        phone,
        birthDate,
        salary,
        hireDate,
        specialty,
      };

      const result = await teacherModel.createTeacher(client, teacherData);

      await client.query("COMMIT");

      res.json({
        message: "Teacher created successfully",
        teacherId: result.teacherid,
      });
    } catch (error) {
      await client.query("ROLLBACK");
      console.error("Error creating teacher:", error);
      res.status(500).json({ error: error.message, details: error.detail });
    } finally {
      client.release();
    }
  },
};

module.exports = teacherController;
