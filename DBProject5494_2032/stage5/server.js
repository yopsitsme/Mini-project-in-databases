// server.js - Node.js Backend Server
const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();
const PORT = 3001;

// Middleware
app.use(cors());
app.use(express.json());

// PostgreSQL Connection Pool
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'backup_1',
  password: 'your_password', // Change this to your PostgreSQL password
  port: 5432,
});

// Test database connection
pool.connect((err, client, release) => {
  if (err) {
    console.error('Error connecting to database:', err.stack);
  } else {
    console.log('Connected to PostgreSQL database');
    release();
  }
});

// API Routes

// 1. Get Teacher Workload
app.get('/api/teacher-workload/:teacherId', async (req, res) => {
  const { teacherId } = req.params;
  
  try {
    const result = await pool.query(
      'SELECT calculate_teacher_workload($1) as result',
      [teacherId]
    );
    
    if (result.rows.length > 0) {
      res.json({ result: result.rows[0].result });
    } else {
      res.status(404).json({ error: 'Teacher not found' });
    }
  } catch (error) {
    console.error('Error fetching teacher workload:', error);
    res.status(500).json({ error: error.message });
  }
});

// 2. Get Student Schedule
app.get('/api/student-schedule/:studentId', async (req, res) => {
  const { studentId } = req.params;
  
  try {
    const result = await pool.query(
      'SELECT * FROM get_student_courses($1)',
      [studentId]
    );
    
    // Organize by day of week
    const schedule = {
      'ראשון': [],
      'שני': [],
      'שלישי': [],
      'רביעי': [],
      'חמישי': [],
      'שישי': [],
      'שבת': []
    };
    
    result.rows.forEach(course => {
      if (course.day_of_week && schedule[course.day_of_week]) {
        schedule[course.day_of_week].push({
          class_name: course.class_name,
          start_time: course.start_time,
          end_time: course.end_time,
          room: course.room,
          teacher_name: course.teacher_name,
          level: course.level
        });
      }
    });
    
    res.json({ schedule });
  } catch (error) {
    console.error('Error fetching student schedule:', error);
    res.status(500).json({ error: error.message });
  }
});

// 3. Get Monthly Revenue Report
app.get('/api/monthly-revenue/:year/:month', async (req, res) => {
  const { year, month } = req.params;
  
  try {
    const result = await pool.query(
      'CALL generate_monthly_revenue_report($1, $2, NULL)',
      [parseInt(year), parseInt(month)]
    );
    
    // Get the OUT parameter result
    const reportQuery = await pool.query(
      'SELECT generate_monthly_revenue_report($1, $2) as report',
      [parseInt(year), parseInt(month)]
    );
    
    if (reportQuery.rows.length > 0) {
      res.json({ report: reportQuery.rows[0].report });
    } else {
      res.status(404).json({ error: 'No data found' });
    }
  } catch (error) {
    console.error('Error generating revenue report:', error);
    res.status(500).json({ error: error.message });
  }
});

// 4. Get All Students
app.get('/api/students', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT s.studentid, p.first_name, p.last_name, p.email, p.phone, 
             p.birth_date, s.addres, s.parentid
      FROM student s
      JOIN person p ON s.studentid = p.personid
      ORDER BY p.first_name, p.last_name
    `);
    
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching students:', error);
    res.status(500).json({ error: error.message });
  }
});

// 5. Get All Teachers
app.get('/api/teachers', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT t.teacherid, p.first_name, p.last_name, p.email, p.phone,
             p.birth_date, t.salary, t.hire_date, t.specialty
      FROM teacher t
      JOIN person p ON t.teacherid = p.personid
      ORDER BY p.first_name, p.last_name
    `);
    
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching teachers:', error);
    res.status(500).json({ error: error.message });
  }
});

// 6. Get All Groups
app.get('/api/groups', async (req, res) => {
  try {
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
    
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching groups:', error);
    res.status(500).json({ error: error.message });
  }
});

// 7. Add Student to Group
app.post('/api/enroll-student', async (req, res) => {
  const { studentId, groupId } = req.body;
  
  try {
    const result = await pool.query(
      'SELECT add_student_to_group($1, $2) as result',
      [studentId, groupId]
    );
    
    res.json({ message: result.rows[0].result });
  } catch (error) {
    console.error('Error enrolling student:', error);
    res.status(500).json({ error: error.message });
  }
});

// 8. Create New Student
app.post('/api/students', async (req, res) => {
  const { 
    firstName, lastName, email, phone, birthDate, 
    address, parentId 
  } = req.body;
  
  const client = await pool.connect();
  
  try {
    await client.query('BEGIN');
    
    // Get next person ID
    const idResult = await client.query(
      'SELECT COALESCE(MAX(personid), 0) + 1 as next_id FROM person'
    );
    const newId = idResult.rows[0].next_id;
    
    // Insert into person table
    await client.query(
      `INSERT INTO person (personid, first_name, last_name, email, phone, birth_date)
       VALUES ($1, $2, $3, $4, $5, $6)`,
      [newId, firstName, lastName, email, phone, birthDate]
    );
    
    // Insert into student table
    await client.query(
      `INSERT INTO student (studentid, addres, parentid)
       VALUES ($1, $2, $3)`,
      [newId, address, parentId]
    );
    
    await client.query('COMMIT');
    
    res.json({ message: 'Student created successfully', studentId: newId });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Error creating student:', error);
    res.status(500).json({ error: error.message });
  } finally {
    client.release();
  }
});

// 9. Create New Teacher
app.post('/api/teachers', async (req, res) => {
  const { 
    firstName, lastName, email, phone, birthDate,
    salary, hireDate, specialty 
  } = req.body;
  
  const client = await pool.connect();
  
  try {
    await client.query('BEGIN');
    
    // Get next person ID
    const idResult = await client.query(
      'SELECT COALESCE(MAX(personid), 0) + 1 as next_id FROM person'
    );
    const newId = idResult.rows[0].next_id;
    
    // Insert into person table
    await client.query(
      `INSERT INTO person (personid, first_name, last_name, email, phone, birth_date)
       VALUES ($1, $2, $3, $4, $5, $6)`,
      [newId, firstName, lastName, email, phone, birthDate]
    );
    
    // Insert into teacher table
    await client.query(
      `INSERT INTO teacher (teacherid, salary, hire_date, specialty)
       VALUES ($1, $2, $3, $4)`,
      [newId, salary, hireDate, specialty]
    );
    
    await client.query('COMMIT');
    
    res.json({ message: 'Teacher created successfully', teacherId: newId });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Error creating teacher:', error);
    res.status(500).json({ error: error.message });
  } finally {
    client.release();
  }
});

// 10. Get Sports Classes
app.get('/api/sports-classes', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT id, name, capacity, cost, duration
      FROM sports_class
      ORDER BY name
    `);
    
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching sports classes:', error);
    res.status(500).json({ error: error.message });
  }
});

// Start server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});