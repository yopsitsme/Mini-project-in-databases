// controllers/sportsClassController.js
const sportsClassModel = require("../models/sportsClassModel");

const sportsClassController = {
  // Get all sports classes
  async getAllSportsClasses(req, res) {
    try {
      const result = await sportsClassModel.getAllSportsClasses();
      res.json(result);
    } catch (error) {
      console.error("Error fetching sports classes:", error);
      res.status(500).json({ error: error.message });
    }
  },

  // Create new sports class
  async createSportsClass(req, res) {
    const { name, capacity, cost, duration } = req.body;

    const pool = require("../config/database");
    const client = await pool.connect();

    try {
      await client.query("BEGIN");

      const classData = {
        name,
        capacity,
        cost,
        duration,
      };

      const result = await sportsClassModel.createSportsClass(
        client,
        classData,
      );

      await client.query("COMMIT");

      res.json({
        message: "Sports class created successfully",
        classId: result.id,
      });
    } catch (error) {
      await client.query("ROLLBACK");
      console.error("Error creating sports class:", error);
      res.status(500).json({ error: error.message });
    } finally {
      client.release();
    }
  },
};

module.exports = sportsClassController;
