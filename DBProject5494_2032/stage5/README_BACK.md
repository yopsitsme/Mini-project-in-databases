# 🚀 Sports Backend — Overview

Welcome — this file explains the backend server, its structure and why pieces exist.

---

## ⚙️ Project Overview

- **Purpose:** REST API backend for the sports management system — manage teachers, students, groups, classes, schedules and revenue reports.
- **Entrypoint:** `server.js` (project root).

Quick snapshot:

- Tech: Node.js + Express, PostgreSQL (`pg`), `cors`.
- SQL: a mix of inline queries, stored procedures/functions, and maintained `.sql` files in the workspace `updated queries`.


---

## 🗂️ Folder structure (important files)

- `server.js` — main Express server wiring middleware and mount points.
- `package.json` / `package-lock.json` — dependencies and scripts.
- `readmeBack.md` — this document.

`src/` (primary code)

- `src/config/database.js` — PostgreSQL Pool (`pg`). Currently uses hard-coded credentials; it's recommended to use environment variables.
- `src/routes/` — route definitions (one router per resource).
- `src/controllers/` — request handlers, validation and transaction management.
- `src/models/` — DB access layer; SQL queries, stored-procedure callers.
- `src/middleware/` — `cors`, request logging, error handler.

Other workspace resources:

- `updated queries/` (workspace root) — maintained complex SQL files referenced by models/controllers.


---

## ▶️ Quick Start (development)

1. Install dependencies:

```bash
npm install
```

2. Configure database: either edit `src/config/database.js` or (recommended) set environment variables:

- `PGUSER` — database user
- `PGHOST` — host (e.g., localhost)
- `PGDATABASE` — database name (e.g., system_final)
- `PGPASSWORD` — DB password
- `PGPORT` — DB port (default 5432)

3. Start server:

```bash
npm start
```

Server base URL: `http://localhost:3001` (endpoints under `/api/*`).


---

## 🛠️ Tools & libraries

- `express` — HTTP server and routing
- `pg` — PostgreSQL client
- `cors` — CORS middleware
- `fs` / `path` — reading maintained SQL files

---

## 🧭 Design & patterns

- Controllers: validate inputs, manage transactions (`BEGIN` / `COMMIT` / `ROLLBACK`), coordinate model calls and prepare JSON responses.
- Models: run SQL (via shared `pool` or a `client` passed from controllers). Complex SQL is maintained in `updated queries` and loaded with `fs`.
- DB logic: heavier business rules live as stored procedures/functions (called from models): e.g., `enroll_student_bulk`, `calculate_teacher_workload`, `generate_monthly_revenue_report`.

This separation keeps JS code focused on orchestration and JSON handling while SQL/stored procedures handle data-heavy logic.

---

## 📦 Routes (summary)

All routes are mounted under `/api/*` in `server.js`. Below is a concise, approachable list grouped by resource. 

### Teachers — `/api/teachers`
- `GET /api/teachers/workload/:teacherId` — teacher workload (calls `calculate_teacher_workload`).
- `GET /api/teachers/schedule/:teacherId` — teacher schedule (grouped by day, uses `get_teacher_schedule`).
- `GET /api/teachers/` — list all teachers.
- `POST /api/teachers/` — create a teacher (expects person fields + salary/hireDate).

### Students — `/api/students`
- `GET /api/students/schedule/:studentId` — student schedule (uses `get_student_courses`).
- `GET /api/students/enrolled-courses/:studentId` — enrolled courses list.
- `GET /api/students/` — list students.
- `GET /api/students/busy-active` — students enrolled in multiple active classes (runs maintained SQL file).
- `POST /api/students/` — create student (inserts into `person` + `student`).
- `POST /api/students/enroll` — bulk enroll: body `{ studentId, groupIds }` -> calls `enroll_student_bulk`.
- `POST /api/students/delete-enrollment` — delete enrollment for `groupIds`.

### Groups — `/api/groups`
- `GET /api/groups/` — list groups.
- `POST /api/groups/` — create a group.
- `PATCH /api/groups/:groupId/assign-teacher` — assign teacher to group.

### Monthly revenue — `/api/monthly-revenue`
- `GET /api/monthly-revenue/:year/:month` — run `generate_monthly_revenue_report` procedure and return its output.

### Sports classes — `/api/sports-classes`
- `GET /api/sports-classes/` — list courses.
- `POST /api/sports-classes/` — create sports class.

### Parents — `/api/parents`
- `GET /api/parents/` — list parents.
- `POST /api/parents/` — create parent (inserts into `person`).

### Year groups — `/api/year-groups`
- `GET /api/year-groups/` — list year groups.

### Schedule — `/api/schedule`
- `GET /api/schedule/weekly-schedule` — complex weekly schedule (reads `updated queries/query7_weekly_schedule_analysis.sql`).
- `GET /api/schedule/courses` — summary counts per course.
- `GET /api/schedule/debug/tables` — quick table counts for debugging.

---

## 🧾 Controllers (what they do and why)

Common controller responsibilities:

1. Validate incoming data (basic checks present; consider adding `express-validator`).
2. Acquire DB `client` for multi-statement changes: `const client = await pool.connect()`.
3. `BEGIN` / call one-or-more `model` functions / `COMMIT` or `ROLLBACK` on error.
4. Return JSON responses and uniform errors via `errorHandler`.

Controller highlights (short):

- `groupController.js` — atomic create/assign operations on `group_of_sports`.
- `parentController.js` — creates `person` entries used as parents.
- `revenueController.js` — orchestrates calling the stored procedure and returning its OUT parameter.
- `scheduleController.js` — delegates heavy SQL to maintained `.sql` files.
- `studentController.js` — create, enroll (calls `enroll_student_bulk`), delete enrollments, and schedule endpoints.
- `teacherController.js` — create teacher + getters that call DB functions.


---

## 🧩 Models (DB access layer)

- Models are thin wrappers that execute SQL and return `rows`. Two common patterns:
  - Read queries: use shared `pool` (`pool.query(...)`).
  - Writes that must be transactional: accept a `client` passed from the controller and use `client.query(...)` inside `BEGIN`/`COMMIT`.

Complex-report strategy:

- Read large/complex SQL from `updated queries/` with `fs` (keeps SQL editable outside JS).
- Use stored procedures for grouped actions or where DB-side logic is preferable.


---

## 🧰 Middleware

- `src/middleware/corsMiddleware.js` — `cors` configured for local frontend at `http://localhost:5173`. Update for production.
- `src/middleware/requestLogger.js` — logs method, path and timing.
- `src/middleware/errorHandler.js` — central error handler returning JSON `{ error, status }`.

Mount order in `server.js` is important: `cors` → `requestLogger` → `express.json()` → routes → `errorHandler`.

---

## ⚙️ Configuration

- DB connection: `src/config/database.js` exports a `pg` Pool. Currently uses hard-coded creds 
