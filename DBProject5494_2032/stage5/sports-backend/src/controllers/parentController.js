// controllers/parentController.js
const parentModel = require("../models/parentModel");

const parentController = {
  // Get all parents
  async getAllParents(req, res) {
    try {
      const result = await parentModel.getAllParents();
      res.json(result);
    } catch (error) {
      console.error("Error fetching parents:", error);
      res.status(500).json({ error: error.message });
    }
  },

  // Create new parent
  async createParent(req, res) {
    const { firstName, lastName, email, phone, birthDate } = req.body;

    const pool = require("../config/database");
    const client = await pool.connect();

    try {
      await client.query("BEGIN");

      const parentData = {
        firstName,
        lastName,
        email,
        phone,
        birthDate,
      };

      const result = await parentModel.createParent(client, parentData);

      await client.query("COMMIT");

      res.json({
        message: "Parent created successfully",
        parentId: result.personid,
      });
    } catch (error) {
      await client.query("ROLLBACK");
      console.error("Error creating parent:", error);
      res.status(500).json({ error: error.message });
    } finally {
      client.release();
    }
  },
};

module.exports = parentController;
