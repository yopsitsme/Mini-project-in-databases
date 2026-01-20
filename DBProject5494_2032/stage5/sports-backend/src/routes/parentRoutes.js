// routes/parentRoutes.js
const express = require("express");
const router = express.Router();
const parentController = require("../controllers/parentController");

// Get all parents
router.get("/", parentController.getAllParents);

// Create new parent
router.post("/", parentController.createParent);

module.exports = router;
