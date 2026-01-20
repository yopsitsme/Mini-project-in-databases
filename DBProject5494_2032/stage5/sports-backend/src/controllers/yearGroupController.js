// controllers/yearGroupController.js
const yearGroupModel = require("../models/yearGroupModel");

const yearGroupController = {
  // Get all year groups
  async getAllYearGroups(req, res) {
    try {
      const result = await yearGroupModel.getAllYearGroups();
      res.json(result);
    } catch (error) {
      console.error("Error fetching year groups:", error);
      res.status(500).json({ error: error.message });
    }
  },
};

module.exports = yearGroupController;
