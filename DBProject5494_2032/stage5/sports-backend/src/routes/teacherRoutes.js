// routes/teacherRoutes.js
const express = require("express");
const router = express.Router();
const teacherController = require("../controllers/teacherController");

// Get teacher workload
router.get("/workload/:teacherId", teacherController.getTeacherWorkload);

// Get teacher schedule
router.get("/schedule/:teacherId", teacherController.getTeacherSchedule);

// Get all teachers
router.get("/", teacherController.getAllTeachers);

// Create new teacher
router.post("/", teacherController.createTeacher);

module.exports = router;
