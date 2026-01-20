## Project Structure - Refactored Code Organization

### Backend Structure (`sports-backend`)

```
sports-backend/
├── server.js                 # Main entry point
└── src/
    ├── config/
    │   └── database.js       # PostgreSQL connection pool
    ├── models/              # Database interaction layer
    │   ├── teacherModel.js
    │   ├── studentModel.js
    │   ├── groupModel.js
    │   ├── revenueModel.js
    │   ├── sportsClassModel.js
    │   ├── parentModel.js
    │   └── yearGroupModel.js
    ├── controllers/         # Business logic layer
    │   ├── teacherController.js
    │   ├── studentController.js
    │   ├── groupController.js
    │   ├── revenueController.js
    │   ├── sportsClassController.js
    │   ├── parentController.js
    │   └── yearGroupController.js
    ├── routes/              # API route definitions
    │   ├── teacherRoutes.js
    │   ├── studentRoutes.js
    │   ├── groupRoutes.js
    │   ├── revenueRoutes.js
    │   ├── sportsClassRoutes.js
    │   ├── parentRoutes.js
    │   └── yearGroupRoutes.js
    └── middleware/          # Express middleware
        ├── corsMiddleware.js
        ├── requestLogger.js
        └── errorHandler.js
```

#### Backend Architecture:

- **Models**: Pure database queries - no business logic
- **Controllers**: Handles requests, calls models, sends responses
- **Routes**: Maps HTTP methods to controller actions
- **Middleware**: CORS, logging, error handling
- **Config**: Database configuration and connection

### Frontend Structure (`sports-frontend`)

```
sports-frontend/
└── src/
    ├── App.jsx              # Main app router
    ├── main.jsx             # Entry point
    ├── index.css            # Global styles
    ├── App.css              # App-specific styles
    ├── pages/               # Full-page components
    │   ├── HomePage.jsx
    │   ├── TeacherPage.jsx
    │   ├── StudentPage.jsx
    │   ├── SecretaryPage.jsx
    │   ├── RevenuePage.jsx
    │   ├── RegisterStudentPage.jsx
    │   └── RegisterTeacherPage.jsx
    ├── components/          # Reusable components
    │   ├── ScheduleDisplay.jsx    # Display schedule table
    │   └── ResultMessage.jsx      # Show success/error messages
    ├── hooks/               # Custom React hooks (expandable)
    └── utils/               # Utility functions and services
        ├── apiService.js    # API call functions
        └── dayMapping.js    # Day name mapping and helpers
```

#### Frontend Architecture:

- **Pages**: Each route/screen is a separate page component
- **Components**: Reusable UI components used across pages
- **Utils**: Helper functions and API service
- **Hooks**: Centralized custom React hooks (for future expansion)

## API Endpoints

All endpoints are prefixed with `/api`:

### Teachers

- `GET /teachers` - Get all teachers
- `GET /teachers/workload/:teacherId` - Get teacher workload
- `GET /teachers/schedule/:teacherId` - Get teacher schedule
- `POST /teachers` - Create new teacher

### Students

- `GET /students` - Get all students
- `GET /students/schedule/:studentId` - Get student schedule
- `POST /students` - Create new student
- `POST /students/enroll` - Enroll student in groups

### Groups

- `GET /groups` - Get all groups
- `POST /groups` - Create new group
- `PATCH /groups/:groupId/assign-teacher` - Assign teacher to group

### Revenue

- `GET /monthly-revenue/:year/:month` - Get monthly revenue report

### Sports Classes

- `GET /sports-classes` - Get all sports classes
- `POST /sports-classes` - Create new sports class

### Parents

- `GET /parents` - Get all parents
- `POST /parents` - Create new parent

### Year Groups

- `GET /year-groups` - Get all year groups

## Running the Application

### Backend

```bash
cd sports-backend
npm install
npm start
```

### Frontend

```bash
cd sports-frontend
npm install
npm run dev
```

## Benefits of This Structure

✅ **Separation of Concerns**: Each layer has a specific responsibility
✅ **Scalability**: Easy to add new features without affecting existing code
✅ **Reusability**: Components and utilities can be easily reused
✅ **Maintainability**: Clear organization makes debugging easier
✅ **Testing**: Each module can be tested independently
✅ **Team Collaboration**: Multiple developers can work on different modules simultaneously

## Future Enhancements

- Add custom hooks in `src/hooks/` for complex state management
- Create more granular components from existing pages
- Add error boundary components
- Implement state management (Redux, Zustand)
- Add unit and integration tests
- Create a services layer for complex business logic
