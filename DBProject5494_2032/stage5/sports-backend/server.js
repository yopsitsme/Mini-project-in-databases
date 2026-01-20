// server.js - Main Backend Server
const express = require("express");
const cors = require("./src/middleware/corsMiddleware");
const requestLogger = require("./src/middleware/requestLogger");
const errorHandler = require("./src/middleware/errorHandler");

// Import routes
const teacherRoutes = require("./src/routes/teacherRoutes");
const studentRoutes = require("./src/routes/studentRoutes");
const groupRoutes = require("./src/routes/groupRoutes");
const revenueRoutes = require("./src/routes/revenueRoutes");
const sportsClassRoutes = require("./src/routes/sportsClassRoutes");
const parentRoutes = require("./src/routes/parentRoutes");
const yearGroupRoutes = require("./src/routes/yearGroupRoutes");

const app = express();
const PORT = 3001;

// Middleware
app.use(cors);
app.use(requestLogger);
app.use(express.json());

// Routes
app.use("/api/teachers", teacherRoutes);
app.use("/api/students", studentRoutes);
app.use("/api/groups", groupRoutes);
app.use("/api/monthly-revenue", revenueRoutes);
app.use("/api/sports-classes", sportsClassRoutes);
app.use("/api/parents", parentRoutes);
app.use("/api/year-groups", yearGroupRoutes);

// Health check endpoint
app.get("/api/health", (req, res) => {
  res.json({ status: "Server is running" });
});

// Error handling middleware (must be last)
app.use(errorHandler);

// Start server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
