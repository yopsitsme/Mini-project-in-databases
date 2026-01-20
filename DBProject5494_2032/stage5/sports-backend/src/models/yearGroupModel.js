// models/yearGroupModel.js
const pool = require("../config/database");

const yearGroupModel = {
  // Get all year groups
  async getAllYearGroups() {
    const result = await pool.query(
      "SELECT * FROM year_groups ORDER BY year_name",
    );
    return result.rows;
  },
};

module.exports = yearGroupModel;
