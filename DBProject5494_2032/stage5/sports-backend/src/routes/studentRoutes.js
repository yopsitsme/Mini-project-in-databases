// routes/studentRoutes.js
const express = require("express");
const router = express.Router();
const studentController = require("../controllers/studentController");

// Get student schedule
router.get("/schedule/:studentId", studentController.getStudentSchedule);

// Get all students
router.get("/", studentController.getAllStudents);

// Create new student
router.post("/", studentController.createStudent);

// Enroll student in groups
router.post("/enroll", studentController.enrollStudent);

module.exports = router;
