// routes/scheduleRoutes.js
const express = require("express");
const router = express.Router();
const scheduleController = require("../controllers/scheduleController");

// Get weekly schedule
router.get("/weekly-schedule", scheduleController.getWeeklySchedule);

// Get all courses
router.get("/courses", scheduleController.getAllCourses);

// Debug endpoint - check if tables exist and have data
router.get("/debug/tables", async (req, res) => {
  try {
    const pool = require("../config/database");

    // Check group_details
    const gdResult = await pool.query("SELECT COUNT(*) FROM group_details");

    // Check group_of_sports
    const gosResult = await pool.query("SELECT COUNT(*) FROM group_of_sports");

    // Check sports_class
    const scResult = await pool.query("SELECT COUNT(*) FROM sports_class");

    res.json({
      group_details_count: gdResult.rows[0].count,
      group_of_sports_count: gosResult.rows[0].count,
      sports_class_count: scResult.rows[0].count,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
