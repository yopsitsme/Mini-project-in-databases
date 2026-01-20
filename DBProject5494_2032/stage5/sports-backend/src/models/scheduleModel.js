// models/scheduleModel.js
const pool = require("../config/database");
const fs = require("fs");
const path = require("path");

const scheduleModel = {
  // Get weekly schedule using Query 7 from updated queries folder
  async getWeeklySchedule() {
    try {
      // Read Query 7 from file
      const query7Path = path.join(
        __dirname,
        "../../../updated queries/query7_weekly_schedule_analysis.sql",
      );
      let query = fs.readFileSync(query7Path, "utf8");

      // Remove comments and clean the query
      query = query
        .split("\n")
        .filter((line) => !line.trim().startsWith("--"))
        .join("\n")
        .trim();

      // Remove trailing semicolon if present
      query = query.replace(/;\s*$/, "");

      const result = await pool.query(query);
      return result.rows;
    } catch (error) {
      console.error("Error in getWeeklySchedule:", error);
      throw error;
    }
  },

  // Get all active courses
  async getAllCourses() {
    try {
      const result = await pool.query(`
        SELECT
          sc.id,
          sc.name AS course_name,
          COUNT(DISTINCT g.groupid) AS total_groups,
          COUNT(DISTINCT pi.studentid) AS total_students
        FROM sports_class sc
        LEFT JOIN group_of_sports g ON sc.id = g.sports_class_id AND g.status = 'ACTIVE'
        LEFT JOIN participate_in pi ON g.groupid = pi.groupid
        GROUP BY sc.id, sc.name
        ORDER BY sc.name
      `);
      return result.rows;
    } catch (error) {
      console.error("Error in getAllCourses:", error);
      throw error;
    }
  },
};

module.exports = scheduleModel;
