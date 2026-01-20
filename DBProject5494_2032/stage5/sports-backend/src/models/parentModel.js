// models/parentModel.js
const pool = require("../config/database");

const parentModel = {
  // Get all parents
  async getAllParents() {
    const result = await pool.query(
      "SELECT * FROM person ORDER BY first_name, last_name",
    );
    return result.rows;
  },

  // Create new parent
  async createParent(client, parentData) {
    const { firstName, lastName, email, phone, birthDate } = parentData;

    // Get next person ID
    const idResult = await client.query(
      "SELECT COALESCE(MAX(personid), 0) + 1 as next_id FROM person",
    );
    const newId = idResult.rows[0].next_id;

    const result = await client.query(
      `INSERT INTO person (personid, first_name, last_name, email, phone, birth_date)
       VALUES ($1, $2, $3, $4, $5, $6)
       RETURNING personid`,
      [newId, firstName, lastName, email || null, phone || null, birthDate],
    );

    return result.rows[0];
  },
};

module.exports = parentModel;
