// controllers/revenueController.js
const revenueModel = require("../models/revenueModel");

const revenueController = {
  // Generate monthly revenue report
  async getMonthlyRevenue(req, res) {
    const { year, month } = req.params;
    const yearInt = parseInt(year);
    const monthInt = parseInt(month);

    const pool = require("../config/database");
    const client = await pool.connect();

    try {
      // Start transaction
      await client.query("BEGIN");

      const reportResult = await revenueModel.generateMonthlyRevenueReport(
        client,
        yearInt,
        monthInt,
      );

      await client.query("COMMIT");

      if (reportResult && reportResult.length > 0) {
        res.json({ report: reportResult[0].report });
      } else {
        res.status(404).json({ error: "No revenue report found" });
      }
    } catch (error) {
      await client.query("ROLLBACK");
      console.error("Error generating revenue report:", error);
      res.status(500).json({ error: error.message });
    } finally {
      client.release();
    }
  },
};

module.exports = revenueController;
