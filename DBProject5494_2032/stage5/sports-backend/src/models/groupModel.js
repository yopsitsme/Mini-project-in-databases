// models/groupModel.js
const pool = require("../config/database");

const groupModel = {
  // Get all groups
  async getAllGroups() {
    const result = await pool.query(`
      SELECT g.groupid, g.level, g.min_age, g.current_amount, g.status,
             sc.name as class_name, sc.capacity, sc.cost,
             p.first_name || ' ' || p.last_name as teacher_name
      FROM group_of_sports g
      JOIN sports_class sc ON g.sports_class_id = sc.id
      JOIN teacher t ON g.teacher_id = t.teacherid
      JOIN person p ON t.teacherid = p.personid
      ORDER BY sc.name, g.level
    `);
    return result.rows;
  },

  // Create new group
  async createGroup(client, groupData) {
    const { level, minAge, teacherId, sportsClassId, yearGroupId } = groupData;

    const result = await client.query(
      `INSERT INTO group_of_sports (level, min_age, teacher_id, sports_class_id, year_group_id, current_amount, status)
       VALUES ($1, $2, $3, $4, $5, 0, 'active')
       RETURNING groupid`,
      [level, minAge, teacherId, sportsClassId, yearGroupId],
    );

    return result.rows[0];
  },

  // Assign teacher to group
  async assignTeacherToGroup(client, groupId, teacherId) {
    const result = await client.query(
      `UPDATE group_of_sports
       SET teacher_id = $1
       WHERE groupid = $2
       RETURNING groupid`,
      [teacherId, groupId],
    );

    if (result.rows.length === 0) {
      throw new Error("Group not found");
    }

    return result.rows[0];
  },
};

module.exports = groupModel;
