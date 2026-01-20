// routes/groupRoutes.js
const express = require("express");
const router = express.Router();
const groupController = require("../controllers/groupController");

// Get all groups
router.get("/", groupController.getAllGroups);

// Create new group
router.post("/", groupController.createGroup);

// Assign teacher to group
router.patch("/:groupId/assign-teacher", groupController.assignTeacherToGroup);

module.exports = router;
