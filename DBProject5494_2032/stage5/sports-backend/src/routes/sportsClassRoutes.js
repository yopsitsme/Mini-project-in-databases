// routes/sportsClassRoutes.js
const express = require("express");
const router = express.Router();
const sportsClassController = require("../controllers/sportsClassController");

// Get all sports classes
router.get("/", sportsClassController.getAllSportsClasses);

// Create new sports class
router.post("/", sportsClassController.createSportsClass);

module.exports = router;
