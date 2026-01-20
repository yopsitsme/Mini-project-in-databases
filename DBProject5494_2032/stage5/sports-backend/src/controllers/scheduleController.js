// controllers/scheduleController.js
const scheduleModel = require("../models/scheduleModel");

const scheduleController = {
  // Get weekly schedule
  async getWeeklySchedule(req, res) {
    try {
      const schedule = await scheduleModel.getWeeklySchedule();
      res.json(schedule);
    } catch (error) {
      console.error("Error fetching weekly schedule:", error);
      res.status(500).json({ error: error.message });
    }
  },

  // Get all courses
  async getAllCourses(req, res) {
    try {
      const courses = await scheduleModel.getAllCourses();
      res.json(courses);
    } catch (error) {
      console.error("Error fetching courses:", error);
      res.status(500).json({ error: error.message });
    }
  },
};

module.exports = scheduleController;
