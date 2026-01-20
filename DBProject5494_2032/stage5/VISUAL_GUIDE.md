# 🗺️ Visual Architecture Guide

## Backend Architecture Flow

```
┌─────────────────────────────────────────────────────────┐
│                    HTTP REQUEST                          │
└────────────────────────┬────────────────────────────────┘
                         │
                         ▼
        ┌────────────────────────────────┐
        │       server.js                 │
        │    (Main Entry Point)          │
        └────────────┬───────────────────┘
                     │
                     ▼
        ┌────────────────────────────────┐
        │      ROUTES (URL Mapping)       │
        │  /api/teachers                  │
        │  /api/students                  │
        │  /api/groups                    │
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
│        Browser / User                 │
└────────────┬─────────────────────────┘
             │
             ▼
  ┌──────────────────────────────┐
  │    PAGES (Main Screens)      │
  │  ├─ HomePage                 │
  │  ├─ TeacherPage              │
  │  ├─ StudentPage              │
  │  ├─ SecretaryPage            │
  │  ├─ RevenuePage              │
  │  ├─ RegisterStudentPage      │
  │  └─ RegisterTeacherPage      │
  └────────────┬─────────────────┘
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

## File Organization Structure

```
sports-backend/src/
│
├─ config/
│  └─ database.js
│     (PostgreSQL connection pool)
│
├─ models/
│  ├─ teacherModel.js
│  ├─ studentModel.js
│  ├─ groupModel.js
│  ├─ revenueModel.js
│  ├─ sportsClassModel.js
│  ├─ parentModel.js
│  └─ yearGroupModel.js
│
├─ controllers/
│  ├─ teacherController.js
│  ├─ studentController.js
│  ├─ groupController.js
│  ├─ revenueController.js
│  ├─ sportsClassController.js
│  ├─ parentController.js
│  └─ yearGroupController.js
│
├─ routes/
│  ├─ teacherRoutes.js
│  ├─ studentRoutes.js
│  ├─ groupRoutes.js
│  ├─ revenueRoutes.js
│  ├─ sportsClassRoutes.js
│  ├─ parentRoutes.js
│  └─ yearGroupRoutes.js
│
└─ middleware/
   ├─ corsMiddleware.js
   ├─ errorHandler.js
   └─ requestLogger.js

sports-frontend/src/
│
├─ pages/
│  ├─ HomePage.jsx
│  ├─ TeacherPage.jsx
│  ├─ StudentPage.jsx
│  ├─ SecretaryPage.jsx
│  ├─ RevenuePage.jsx
│  ├─ RegisterStudentPage.jsx
│  └─ RegisterTeacherPage.jsx
│
├─ components/
│  ├─ ScheduleDisplay.jsx
│  └─ ResultMessage.jsx
│
├─ utils/
│  ├─ apiService.js
│  └─ dayMapping.js
│
├─ hooks/
│  (Ready for custom hooks)
│
├─ App.jsx
│  (Main router)
│
└─ ...styles & assets
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
│  getTeacherSchedule(1)              │
│                                     │
│  Makes HTTP request                 │
│  GET /api/teachers/schedule/1       │
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

## Data Flow Summary

```
Frontend          Backend          Database
───────────────────────────────────────────

User Action   →   Page Component
              →   API Service
                  ↓
                  HTTP Request
                  ↓
              Router (URL match)
              ↓
              Controller (logic)
              ↓
              Model (query build)
              ↓                          PostgreSQL
              Pool.query() ──────────→  [Execute]
                              ←────    [Results]
              ↑ Receive rows
              ↓
              Model (return data)
              ↓
              Controller (format)
              ↓
                  HTTP Response
                  ↓
                  Promise
              ↓
              API Service
              ↓
              Page Component
              ↓
              Re-render UI  ← Display to user
```

## Component Hierarchy

```
App.jsx
│
├─ HomePage
│
├─ TeacherPage
│  └─ ScheduleDisplay (component)
│
├─ StudentPage
│  └─ ScheduleDisplay (component)
│
├─ SecretaryPage
│
├─ RevenuePage
│
├─ RegisterStudentPage
│
├─ RegisterTeacherPage
│
└─ ResultMessage (component)
```

## API Endpoint Hierarchy

```
/api/
│
├─ /teachers
│  ├─ GET /              (all teachers)
│  ├─ GET /workload/:id
│  ├─ GET /schedule/:id
│  └─ POST /             (create)
│
├─ /students
│  ├─ GET /              (all students)
│  ├─ GET /schedule/:id
│  ├─ POST /             (create)
│  └─ POST /enroll       (enroll)
│
├─ /groups
│  ├─ GET /              (all groups)
│  ├─ POST /             (create)
│  └─ PATCH /:id/assign-teacher
│
├─ /monthly-revenue
│  └─ GET /:year/:month
│
├─ /sports-classes
│  ├─ GET /              (all)
│  └─ POST /             (create)
│
├─ /parents
│  ├─ GET /              (all)
│  └─ POST /             (create)
│
└─ /year-groups
   └─ GET /              (all)
```

## Development Workflow

```
Developer starts work
        │
        ▼
1. Create Database Query
   └─ Add to models/
        │
        ▼
2. Create Business Logic
   └─ Add to controllers/
        │
        ▼
3. Create Route
   └─ Add to routes/
        │
        ▼
4. Create API Call Method
   └─ Add to utils/apiService.js
        │
        ▼
5. Create UI Component
   └─ Add to pages/ or components/
        │
        ▼
6. Test in Browser
   └─ Verify functionality
        │
        ▼
Feature Complete! ✅
```

---

**These visual guides help understand how all parts work together!**
