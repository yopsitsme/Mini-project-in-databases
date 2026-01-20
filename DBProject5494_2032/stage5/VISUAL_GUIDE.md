# 🗺️ Visual Architecture Guide

## Backend Architecture Flow

```
┌─────────────────────────────────────────────────────────┐
│                    HTTP REQUEST                         │
└────────────────────────┬────────────────────────────────┘
                         │
                         ▼
        ┌────────────────────────────────┐
        │       server.js                │
        │    (Main Entry Point)          │
        └────────────┬───────────────────┘
                     │
                     ▼
        ┌────────────────────────────────┐
        │      ROUTES (URL Mapping)      │
        │  /api/teachers                 │
        │  /api/students                 │
        │  /api/groups                   │
        └────────────┬───────────────────┘
                     │
                     ▼
        ┌────────────────────────────────┐
        │    CONTROLLERS (Logic)         │
        │  - Validate input              │
        │  - Call models                 │
        │  - Send response               │
        └────────────┬───────────────────┘
                     │
                     ▼
        ┌────────────────────────────────┐
        │      MODELS (Queries)          │
        │  - Build SQL                   │
        │  - Execute query               │
        │  - Return data                 │
        └────────────┬───────────────────┘
                     │
                     ▼
        ┌────────────────────────────────┐
        │      DATABASE (PostgreSQL)     │
        │  - Store data                  │
        │  - Process queries             │
        └────────────────────────────────┘
```

## Frontend Architecture Flow

```
┌──────────────────────────────────────┐
│        Browser / User                │
└────────────┬─────────────────────────┘
             │
             ▼
  ┌─────────────────────────────────┐
  │    PAGES (Main Screens)         │
  │  ├─ HomePage                    │
  │  ├─ TeacherPage                 │
  │  ├─ StudentPage                 │
  │  ├─ SecretaryPage               │
  │  ├─ RevenuePage                 │
  │  ├─ RegisterStudentPage         │
  │  ├─ RegisterTeacherPage         │
  │  ├─ EnrollStudentPage           │
  │  ├─ DeleteStudentFromCoursePage │
  │  └─ WeeklySchedulePage          │
  └────────────┬────────────────────┘
               │
               ▼
  ┌──────────────────────────────┐
  │   COMPONENTS (UI Pieces)     │
  │  ├─ ScheduleDisplay          │
  │  └─ ResultMessage            │
  └────────────┬─────────────────┘
               │
               ▼
  ┌──────────────────────────────┐
  │   UTILS (Services)           │
  │  ├─ apiService.js            │
  │  └─ dayMapping.js            │
  └────────────┬─────────────────┘
               │
               ▼
  ┌──────────────────────────────┐
  │    API CALLS (Network)       │
  │  GET /api/teachers           │
  │  POST /api/students          │
  │  GET /api/groups             │
  │  etc...                      │
  └────────────┬─────────────────┘
               │
               ▼
  ┌──────────────────────────────┐
  │   BACKEND API SERVER         │
  │   (localhost:3001)           │
  └──────────────────────────────┘
```

## Request-Response Flow (Example)

```
USER INTERACTION
      │
      │ Click "Get Teacher Schedule"
      │
      ▼
┌─────────────────────────────────────┐
│  Page: TeacherPage.jsx              │
│  - User enters teacher ID: 1        │
│  - Clicks "View Schedule"           │
└──────────────┬──────────────────────┘
               │
               │ Calls apiService
               │
               ▼
┌─────────────────────────────────────┐
│  Util: apiService.js                │
│  getTeacherSchedule(151)            │
│                                     │
│  Makes HTTP request                 │
│  GET /api/teachers/schedule/151     │
└──────────────┬──────────────────────┘
               │
               │ HTTP Request over network
               │
               ▼
┌─────────────────────────────────────┐
│  Route: teacherRoutes.js            │
│  router.get("/schedule/:teacherId", │
│    teacherController.getSchedule)   │
└──────────────┬──────────────────────┘
               │
               │ Directs to controller
               │
               ▼
┌─────────────────────────────────────┐
│  Controller: teacherController.js   │
│  getTeacherSchedule(req, res)       │
│  - Validates input                  │
│  - Calls model                      │
└──────────────┬──────────────────────┘
               │
               │ Calls model
               │
               ▼
┌─────────────────────────────────────┐
│  Model: teacherModel.js             │
│  getTeacherSchedule(teacherId)      │
│                                     │
│  pool.query(                        │
│    "SELECT * FROM get_teacher...    │
│  )                                  │
└──────────────┬──────────────────────┘
               │
               │ Database query
               │
               ▼
┌─────────────────────────────────────┐
│  Database: PostgreSQL               │
│  - Execute query                    │
│  - Return results                   │
└──────────────┬──────────────────────┘
               │
               │ Query results
               │
               ▼
┌─────────────────────────────────────┐
│  Model: Returns data                │
│  [ {course1}, {course2}, ... ]      │
└──────────────┬──────────────────────┘
               │
               │ Controller receives data
               │
               ▼
┌─────────────────────────────────────┐
│  Controller: Formats response       │
│  res.json({                         │
│    schedule: {...}                  │
│  })                                 │
└──────────────┬──────────────────────┘
               │
               │ HTTP Response
               │
               ▼
┌─────────────────────────────────────┐
│  apiService: Receives JSON          │
│  Returns promise with data          │
└──────────────┬──────────────────────┘
               │
               │ Data to component
               │
               ▼
┌─────────────────────────────────────┐
│  Page: TeacherPage.jsx              │
│  - Updates state                    │
│  - Re-renders with data             │
└──────────────┬──────────────────────┘
               │
               │ Display in browser
               │
               ▼
┌─────────────────────────────────────┐
│  BROWSER: Shows schedule            │
│  [Display formatted schedule table] │
└─────────────────────────────────────┘
```
