// models/sportsClassModel.js
const pool = require("../config/database");

const sportsClassModel = {
  // Get all sports classes
  async getAllSportsClasses() {
    const result = await pool.query("SELECT * FROM sports_class ORDER BY name");
    return result.rows;
  },

  // Create new sports class
  async createSportsClass(client, classData) {
    const { name, capacity, cost, duration } = classData;

    const result = await client.query(
      `INSERT INTO sports_class (name, capacity, cost, duration)
       VALUES ($1, $2, $3, $4)
       RETURNING id`,
      [name, capacity, cost, duration || null],
    );

    return result.rows[0];
  },
};

module.exports = sportsClassModel;
