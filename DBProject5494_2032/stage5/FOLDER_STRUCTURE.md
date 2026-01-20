## 🗂️ Folder Structure

```
stage5/
├── backup5.sql
├── FOLDER_STRUCTURE.md
├── node_modules/
├── pictures/
│   ├── deleteStudentPage.png
│   ├── enrollStudentPage.png
│   ├── homePage.png
│   ├── overloadedStudents.png
│   ├── registerStudentPage.png
│   ├── registerTeacherPage.png
│   ├── resultMassageCompanent.png
│   ├── revenuePage.png
│   ├── secretaryPage.png
│   ├── studentPage.png
│   ├── teacherPage.png
│   └── weeklySchedulePage.png
├── README_BACK.md
├── README_FRONT.md
├── SETUP_GUIDE.md
├── sports-backend/
│   ├── package.json
│   ├── server.js                     ← Main entry point
│   └── src/                          ← 28 organized files
│       ├── config/
│       │   └── database.js
│       ├── controllers/              ← 8 files
│       │   ├── groupController.js
│       │   ├── parentController.js
│       │   ├── revenueController.js
│       │   ├── scheduleController.js
│       │   ├── sportsClassController.js
│       │   ├── studentController.js
│       │   ├── teacherController.js
│       │   └── yearGroupController.js
│       ├── middleware/               ← 3 files
│       │   ├── corsMiddleware.js
│       │   ├── errorHandler.js
│       │   └── requestLogger.js
│       ├── models/                   ← 8 files
│       │   ├── groupModel.js
│       │   ├── parentModel.js
│       │   ├── revenueModel.js
│       │   ├── scheduleModel.js
│       │   ├── sportsClassModel.js
│       │   ├── studentModel.js
│       │   ├── teacherModel.js
│       │   └── yearGroupModel.js
│       └── routes/                   ← 8 files
│           ├── groupRoutes.js
│           ├── parentRoutes.js
│           ├── revenueRoutes.js
│           ├── scheduleRoutes.js
│           ├── sportsClassRoutes.js
│           ├── studentRoutes.js
│           ├── teacherRoutes.js
│           └── yearGroupRoutes.js
├── sports-frontend/
│   ├── eslint.config.js
│   ├── index.html
│   ├── package.json
│   ├── README.md
│   ├── vite.config.js
│   ├── public/
│   │   └── vite.svg
│   └── src/                          ← 18 organized files
│       ├── App.css
│       ├── App.jsx                   ← Main router
│       ├── assets/
│       │   └── react.svg
│       ├── components/               ← 2 files
│       │   ├── ResultMessage.jsx
│       │   └── ScheduleDisplay.jsx
│       ├── index.css
│       ├── main.jsx
│       ├── pages/                    ← 11 files
│       │   ├── DeleteStudentFromCoursePage.jsx
│       │   ├── EnrollStudentPage.jsx
│       │   ├── HomePage.jsx
│       │   ├── RegisterStudentPage.jsx
│       │   ├── RegisterTeacherPage.jsx
│       │   ├── RevenuePage.jsx
│       │   ├── SecretaryPage.jsx
│       │   ├── StudentPage.jsx
│       │   ├── TeacherPage.jsx
│       │   ├── WeeklySchedulePage.css
│       │   └── WeeklySchedulePage.jsx
│       └── utils/                    ← 2 files
│           ├── apiService.js
│           └── dayMapping.js
├── updated queries/
│   ├── query5_students_enrolled_in_multiple_classes.sql
│   └── query7_weekly_schedule_analysis.sql
└── VISUAL_GUIDE.md
```
