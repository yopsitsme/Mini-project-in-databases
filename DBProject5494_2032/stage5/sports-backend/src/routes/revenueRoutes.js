// routes/revenueRoutes.js
const express = require("express");
const router = express.Router();
const revenueController = require("../controllers/revenueController");

// Get monthly revenue report
router.get("/:year/:month", revenueController.getMonthlyRevenue);

module.exports = router;
