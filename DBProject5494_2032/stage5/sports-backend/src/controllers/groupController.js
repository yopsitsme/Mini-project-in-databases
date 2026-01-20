// controllers/groupController.js
const groupModel = require("../models/groupModel");

const groupController = {
  // Get all groups
  async getAllGroups(req, res) {
    try {
      const result = await groupModel.getAllGroups();
      res.json(result);
    } catch (error) {
      console.error("Error fetching groups:", error);
      res.status(500).json({ error: error.message });
    }
  },

  // Create new group
  async createGroup(req, res) {
    const { level, minAge, teacherId, sportsClassId, yearGroupId } = req.body;

    const pool = require("../config/database");
    const client = await pool.connect();

    try {
      await client.query("BEGIN");

      const groupData = {
        level,
        minAge,
        teacherId,
        sportsClassId,
        yearGroupId,
      };

      const result = await groupModel.createGroup(client, groupData);

      await client.query("COMMIT");

      res.json({
        message: "Group created successfully",
        groupId: result.groupid,
      });
    } catch (error) {
      await client.query("ROLLBACK");
      console.error("Error creating group:", error);
      res.status(500).json({ error: error.message });
    } finally {
      client.release();
    }
  },

  // Assign teacher to group
  async assignTeacherToGroup(req, res) {
    const { groupId } = req.params;
    const { teacherId } = req.body;

    if (!groupId || !teacherId) {
      return res.status(400).json({
        error: "groupId and teacherId are required",
      });
    }

    const pool = require("../config/database");
    const client = await pool.connect();

    try {
      await client.query("BEGIN");

      const result = await groupModel.assignTeacherToGroup(
        client,
        groupId,
        teacherId,
      );

      await client.query("COMMIT");

      res.json({
        message: "Teacher assigned successfully",
        groupId: result.groupid,
      });
    } catch (error) {
      await client.query("ROLLBACK");
      console.error("Error assigning teacher:", error);
      res.status(500).json({ error: error.message });
    } finally {
      client.release();
    }
  },
};

module.exports = groupController;
