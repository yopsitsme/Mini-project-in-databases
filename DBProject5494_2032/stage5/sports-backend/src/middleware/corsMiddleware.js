// middleware/corsMiddleware.js
const cors = require("cors");

const corsOptions = {
  origin: "http://localhost:5173", // Change this to your frontend URL in production
  credentials: true,
};

module.exports = cors(corsOptions);
