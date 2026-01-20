// controllers/studentController.js
const studentModel = require("../models/studentModel");

const studentController = {
  // Get student schedule
  async getStudentSchedule(req, res) {
    const { studentId } = req.params;
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
      const result = await studentModel.getStudentSchedule(studentId);

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
          teacher: course.teacher_name,
          capacity: course.capacity,
          currentAmount: course.current_amount,
          groupId: course.groupid,
        });
      });

      res.json({ schedule });
    } catch (error) {
      console.error("Error fetching student schedule:", error);
      res.status(500).json({ error: error.message });
    }
  },

  // Get all students
  async getAllStudents(req, res) {
    try {
      const result = await studentModel.getAllStudents();
      res.json(result);
    } catch (error) {
      console.error("Error fetching students:", error);
      res.status(500).json({ error: error.message });
    }
  },

  // Create new student
  async createStudent(req, res) {
    const { firstName, lastName, email, phone, birthDate, address, parentId } =
      req.body;

    // Validation
    if (!firstName || !lastName || !birthDate) {
      return res.status(400).json({
        error:
          "Missing required fields: firstName, lastName, and birthDate are required",
      });
    }

    const pool = require("../config/database");
    const client = await pool.connect();

    try {
      await client.query("BEGIN");

      const studentData = {
        firstName,
        lastName,
        email,
        phone,
        birthDate,
        address,
        parentId,
      };

      const result = await studentModel.createStudent(client, studentData);

      await client.query("COMMIT");

      res.json({
        message: "Student created successfully",
        studentId: result.studentid,
      });
    } catch (error) {
      await client.query("ROLLBACK");
      console.error("Error creating student:", error);
      res.status(500).json({ error: error.message, details: error.detail });
    } finally {
      client.release();
    }
  },

  // Enroll student in groups
  async enrollStudent(req, res) {
    const { studentId, groupIds } = req.body;

    // Validate input
    if (!studentId) {
      return res.status(400).json({ error: "Student ID is required" });
    }

    if (!groupIds || !Array.isArray(groupIds) || groupIds.length === 0) {
      return res
        .status(400)
        .json({ error: "At least one group ID is required" });
    }

    const pool = require("../config/database");
    const client = await pool.connect();

    try {
      await client.query("BEGIN");

      await studentModel.enrollStudentBulk(client, studentId, groupIds);

      await client.query("COMMIT");

      res.json({
        message: "Enrollment completed successfully",
        studentId: studentId,
        groupIds: groupIds,
      });
    } catch (error) {
      try {
        await client.query("ROLLBACK");
      } catch (rollbackError) {
        console.error("Rollback error:", rollbackError);
      }
      console.error("Error enrolling student:", error);
      res.status(500).json({ error: error.message });
    } finally {
      client.release();
    }
  },
};

module.exports = studentController;
