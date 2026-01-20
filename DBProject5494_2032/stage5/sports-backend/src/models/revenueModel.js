// models/revenueModel.js
const pool = require("../config/database");

const revenueModel = {
  // Generate monthly revenue report
  async generateMonthlyRevenueReport(client, year, month) {
    // Create a temporary variable to capture the OUT parameter
    await client.query("CREATE TEMP TABLE temp_report (report TEXT)");

    // Call the procedure with values directly (safe since they're integers)
    await client.query(
      `DO $$
        DECLARE v_report TEXT;
        BEGIN
          CALL generate_monthly_revenue_report(${year}, ${month}, v_report);
          INSERT INTO temp_report VALUES (v_report);
        END $$`,
    );

    // Retrieve the report
    const reportResult = await client.query("SELECT report FROM temp_report");

    return reportResult.rows;
  },
};

module.exports = revenueModel;
