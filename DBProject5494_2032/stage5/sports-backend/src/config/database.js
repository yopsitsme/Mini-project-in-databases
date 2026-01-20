// config/database.js - PostgreSQL Connection Pool
const { Pool } = require("pg");

const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "backup_1",
  password: "1234", // Change this to your PostgreSQL password
  port: 5432,
});

// Test database connection
pool.connect((err, client, release) => {
  if (err) {
    console.error("Error connecting to database:", err.stack);
  } else {
    console.log("Connected to PostgreSQL database");
    release();
  }
});

module.exports = pool;
