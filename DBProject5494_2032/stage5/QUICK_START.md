# Quick Start Guide

## Project Structure Overview

Your sports management system has been refactored into a professional, scalable architecture.

### Directory Layout

```
stage5/
├── sports-backend/           # Node.js/Express API Server
│   ├── server.js            # Main entry point
│   ├── package.json
│   └── src/
│       ├── config/          # Database configuration
│       ├── models/          # Database queries
│       ├── controllers/     # Business logic
│       ├── routes/          # API endpoints
│       └── middleware/      # Express middleware
│
└── sports-frontend/          # React/Vite Frontend
    ├── vite.config.js
    ├── package.json
    ├── index.html
    └── src/
        ├── App.jsx          # Main router
        ├── pages/           # Full-page components (7 pages)
        ├── components/      # Reusable components
        ├── utils/           # API service & helpers
        ├── hooks/           # Custom React hooks (expandable)
        └── ...styles
```

## Starting the Application

### Step 1: Start Backend

```bash
cd sports-backend
npm install        # Only needed first time
npm start
```

Expected output:

```
Connected to PostgreSQL database
Server is running on http://localhost:3001
```

### Step 2: Start Frontend

In another terminal:

```bash
cd sports-frontend
npm install        # Only needed first time
npm run dev
```

Expected output:

```
  Local:   http://localhost:5173/
```

Then open `http://localhost:5173` in your browser.

## Component Organization

### Pages (Full Screens)

Located in `src/pages/`:

- `HomePage.jsx` - Main menu with role selection
- `TeacherPage.jsx` - Teacher dashboard
- `StudentPage.jsx` - Student dashboard
- `SecretaryPage.jsx` - Secretary menu
- `RevenuePage.jsx` - Monthly revenue report
- `RegisterStudentPage.jsx` - Student registration
- `RegisterTeacherPage.jsx` - Teacher registration

### Reusable Components

Located in `src/components/`:

- `ScheduleDisplay.jsx` - Displays schedules in table format
- `ResultMessage.jsx` - Shows success/error feedback

### Utilities

Located in `src/utils/`:

- `apiService.js` - All API calls for backend communication
- `dayMapping.js` - Day translations and helpers

## Backend Architecture

### Models (Data Access Layer)

Files in `src/models/` handle database queries:

```javascript
// Example: teacherModel.js
async getTeacherWorkload(teacherId) { ... }
async getTeacherSchedule(teacherId) { ... }
async getAllTeachers() { ... }
async createTeacher(client, teacherData) { ... }
```

### Controllers (Business Logic Layer)

Files in `src/controllers/` handle requests:

```javascript
// Example: teacherController.js
async getTeacherWorkload(req, res) { ... }
async createTeacher(req, res) { ... }
```

### Routes (API Endpoints)

Files in `src/routes/` define endpoints:

```javascript
// Example: teacherRoutes.js
router.get("/workload/:teacherId", teacherController.getTeacherWorkload);
router.post("/", teacherController.createTeacher);
```

## API Usage Examples

### Get Teacher Schedule

```javascript
// From apiService.js
const scheduleData = await apiService.getTeacherSchedule(teacherId);
```

**API Endpoint:** `GET http://localhost:3001/api/teachers/schedule/:teacherId`

### Register New Student

```javascript
// From apiService.js
const result = await apiService.createStudent(studentData);
```

**API Endpoint:** `POST http://localhost:3001/api/students`

### Get Monthly Revenue

```javascript
// From apiService.js
const report = await apiService.getMonthlyRevenue(year, month);
```

**API Endpoint:** `GET http://localhost:3001/api/monthly-revenue/:year/:month`

See `REFACTORING_GUIDE.md` for complete API endpoint list.

## File Sizes (Before vs After)

### Backend

- **Before:** `server.js` = 646 lines (all in one file)
- **After:** `server.js` = ~50 lines + 25 organized modules

### Frontend

- **Before:** `App.jsx` = 2000+ lines (all logic in one file)
- **After:** `App.jsx` = ~80 lines + 7 pages + 2 components

## Development Workflow

### Adding a New Page

1. Create file in `src/pages/NewPage.jsx`
2. Export as named export
3. Import in `App.jsx`
4. Add case to `renderScreen()` switch

### Adding a New API Endpoint

1. Create query in `src/models/yourModel.js`
2. Create handler in `src/controllers/yourController.js`
3. Create routes in `src/routes/yourRoutes.js`
4. Import routes in `server.js`
5. Add API method to `src/utils/apiService.js`

### Adding a New Component

1. Create file in `src/components/YourComponent.jsx`
2. Export as default
3. Import where needed
4. Use in your pages/components

## Debugging Tips

### Backend Issues

- Check `src/config/database.js` for PostgreSQL credentials
- Ensure PostgreSQL is running: `pg_isready -h localhost`
- Check console output for error messages

### Frontend Issues

- Check browser console (F12) for JavaScript errors
- Verify API_URL in `src/utils/apiService.js` is correct
- Check network tab to see API requests

### Common Problems

- **Backend won't start**: Check PostgreSQL is running and port 5432 is available
- **Frontend won't load**: Ensure backend is running on port 3001
- **API calls fail**: Check backend console for error messages
- **Styles missing**: Verify Bootstrap CSS is loaded in `main.jsx`

## Next Steps

1. ✅ Refactoring complete
2. Test all features
3. Deploy to production (update credentials in `database.js`)
4. Add more features as needed
5. Consider adding TypeScript for type safety

## Need Help?

Check these files for more information:

- `REFACTORING_GUIDE.md` - Detailed structure documentation
- `REFACTORING_SUMMARY.md` - What was changed and why

---

**Happy coding!** 🚀
