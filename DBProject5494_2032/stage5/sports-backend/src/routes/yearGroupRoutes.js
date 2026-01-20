// routes/yearGroupRoutes.js
const express = require("express");
const router = express.Router();
const yearGroupController = require("../controllers/yearGroupController");

// Get all year groups
router.get("/", yearGroupController.getAllYearGroups);

module.exports = router;
