// routes/studentRoutes.js
const express = require("express");
const router = express.Router();
const studentController = require("../controllers/studentController");

// Get student schedule
router.get("/schedule/:studentId", studentController.getStudentSchedule);

// Get enrolled courses for a student
router.get(
  "/enrolled-courses/:studentId",
  studentController.getEnrolledCourses,
);

// Get all students
router.get("/", studentController.getAllStudents);

// Get students enrolled in more than one active course (busy/active students)
router.get("/busy-active", studentController.getBusyActiveStudents);

// Create new student
router.post("/", studentController.createStudent);

// Enroll student in groups
router.post("/enroll", studentController.enrollStudent);

// Delete student from courses
router.post("/delete-enrollment", studentController.deleteEnrollment);

module.exports = router;
