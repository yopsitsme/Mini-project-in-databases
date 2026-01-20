## 🎯 Sports Frontend Overview

- Purpose: Frontend UI for the Sports Management — tools for Teachers, Students and Secretary (register/enroll/delete, revenue, weekly schedule).
- Stack & tools:
  - ⚡ Vite (dev server, fast HMR)
  - ⚛️ React 19 (UI)
  - 🎨 Bootstrap 5 + Bootstrap Icons (layout & icons)
  - 🔁 Fetch API (network) wrapped by `apiService` helper
  - 🔍 ESLint (quality)

This document explains every file under the `sports-frontend` project and then splits the explanation into: Pages, Components, Utils, and `App.jsx` (how navigation/state works). It aims to be approachable for a new developer.

## 📁 Project layout (top-level)

- Root: [stage5/sports-frontend](stage5/sports-frontend)
  - `package.json`, `vite.config.js`, `index.html` — standard Vite project files.
  - `public/` — static assets (served as-is).
  - `src/` — app source (described below).

## 🧭 Entry & Shell

- Entry: [stage5/sports-frontend/src/main.jsx](stage5/sports-frontend/src/main.jsx)
  - Bootstraps React and renders `<App />`.
  - Imports global styles: `bootstrap` CSS, `index.css`, `App.css`.

- Shell: [stage5/sports-frontend/src/App.jsx](stage5/sports-frontend/src/App.jsx)
  - Minimal single-file router: keeps `currentScreen` state and conditionally renders pages.
  - Holds `ResultMessage` state (type/title/message) and exposes callback props to child pages for navigation and result display.

## 🧩 Pages — what’s inside each file and why

Notes: every `page` component is a screen. They fetch data (when needed), normalize backend responses and render presentational components.

- [stage5/sports-frontend/src/pages/HomePage.jsx](stage5/sports-frontend/src/pages/HomePage.jsx)
  - Simple landing screen with three big buttons: Teacher, Student, Secretary.
  - Calls `onSelectScreen("teacher"|"student"|"secretary")` (provided by `App.jsx`).

- [stage5/sports-frontend/src/pages/TeacherPage.jsx](stage5/sports-frontend/src/pages/TeacherPage.jsx)
  - UI: teacher ID input, a button to fetch details.
  - Behavior:
    - Calls `apiService.getTeacherWorkload(teacherId)` to get a text/numeric workload summary.
    - Calls `apiService.getTeacherSchedule(teacherId)` to get a schedule object.
    - Stores `teacherWorkload` and `teacherSchedule` and passes schedule to `ScheduleDisplay`.
  - Why: separates data retrieval (apiService) from display, shows teacher-centric data quickly.

- [stage5/sports-frontend/src/pages/StudentPage.jsx](stage5/sports-frontend/src/pages/StudentPage.jsx)
  - UI: student ID input, fetch button.
  - Behavior: `apiService.getStudentSchedule(studentId)` → render via `ScheduleDisplay`.
  - Why: identical pattern to TeacherPage for consistency; pages stay small and focus on domain logic.

- [stage5/sports-frontend/src/pages/SecretaryPage.jsx](stage5/sports-frontend/src/pages/SecretaryPage.jsx)
  - Central admin screen with navigation to secretary flows.
  - Extra widget: fetches `GET /api/students/busy-active` to display a table of students with many enrollments.
  - Why: a single place for the secretary to start actions and inspect common lists.

- [stage5/sports-frontend/src/pages/RegisterTeacherPage.jsx](stage5/sports-frontend/src/pages/RegisterTeacherPage.jsx)
  - Full form for creating a teacher (first/last name, contact, birth/hire dates, salary, specialty).
  - On submit: calls `apiService.createTeacher(teacherData)`. On success calls `onShowResult("success", ...)`.
  - Why: small controlled form with validation via required attributes; keeps creation logic central.

- [stage5/sports-frontend/src/pages/RegisterStudentPage.jsx](stage5/sports-frontend/src/pages/RegisterStudentPage.jsx)
  - Form for creating a student with parent association. Two modes:
    - existing parent: select from loaded parents (`GET /api/parents`),
    - new parent: inline form, posted to `/api/parents` then student created with returned `parentId`.
  - On success shows `onShowResult` with student id.
  - Why: reflects real workflow—students must be linked to parents; UI supports both flows.

- [stage5/sports-frontend/src/pages/EnrollStudentPage.jsx](stage5/sports-frontend/src/pages/EnrollStudentPage.jsx)
  - Loads groups from `GET /api/groups`, filters for available capacity, renders selectable cards.
  - Posts to `/api/students/enroll` with `{ studentId, groupIds }`.
  - UX: choose multiple groups, shows count and confirmation via `onShowResult`.

- [stage5/sports-frontend/src/pages/DeleteStudentFromCoursePage.jsx](stage5/sports-frontend/src/pages/DeleteStudentFromCoursePage.jsx)
  - Fetches enrolled courses for a student via `GET /api/students/enrolled-courses/:id`.
  - Allows selecting enrolled groups and posts to `/api/students/delete-enrollment` with `{ studentId, groupIds }`.
  - Why: mirrors enroll flow but for deletion, re-uses card/list UI pattern for consistency.

- [stage5/sports-frontend/src/pages/WeeklySchedulePage.jsx](stage5/sports-frontend/src/pages/WeeklySchedulePage.jsx)
  - Fetches `GET /api/schedule/weekly-schedule`.
  - Normalizes diverse backend payloads (array-of-items, numeric day values, or mapped schedule object) into a single Hebrew-keyed schedule using `initializeSchedule()` and `dayMapping`.
  - Passes normalized schedule to `ScheduleDisplay` with `showLevel={false}` for compact weekly view.

## 🧩 Components — reusable building blocks

- [stage5/sports-frontend/src/components/ScheduleDisplay.jsx](stage5/sports-frontend/src/components/ScheduleDisplay.jsx)
  - Purpose: consistent rendering of a 7-day schedule table.
  - Input: `schedule` object (flexible shapes accepted) and `showLevel` boolean.
  - How it works:
    - Calls `initializeSchedule()` to build a base with Hebrew-day keys.
    - Detects if input uses Hebrew keys already — merges and renders directly.
    - Otherwise attempts to map English day names or capitalized variants using `dayMapping` (from `src/utils/dayMapping.js`).
    - Renders each day's list of classes as small cards showing `className`, `level`, `time`, `location`, and `teacher`.
  - Why: centralizing the normalization logic here lets pages send different shapes while keeping display consistent.

- [stage5/sports-frontend/src/components/ResultMessage.jsx](stage5/sports-frontend/src/components/ResultMessage.jsx)
  - Purpose: full-screen success/error result view.
  - Inputs: `type` ('success'|'error'), `title`, `message`, `onClose` callback.
  - Visuals: color and icon change with `type`; uses Bootstrap utility classes for layout.

## 🔧 Utils — helpers and API client

- [stage5/sports-frontend/src/utils/apiService.js](stage5/sports-frontend/src/utils/apiService.js)
  - Single place for all network calls. Base: `http://localhost:3001/api`.
  - Exposes async functions: `getTeacherWorkload`, `getTeacherSchedule`, `getAllTeachers`, `createTeacher`, `getStudentSchedule`, `getAllStudents`, `createStudent`, `enrollStudent`, `getAllGroups`, `createGroup`, `getMonthlyRevenue`, and more.
  - Implementation detail: each function `fetch()`es and returns `response.json()`. Pages sometimes check `response.ok` before parsing (e.g., `WeeklySchedulePage`) — consider adding centralized error handling or a small wrapper that throws on non-ok.

- [stage5/sports-frontend/src/utils/dayMapping.js](stage5/sports-frontend/src/utils/dayMapping.js)
  - Exports `dayMapping` (English → Hebrew) and `initializeSchedule()` returning empty arrays for the 7 Hebrew days.
  - Used by `ScheduleDisplay` and `WeeklySchedulePage` to normalize inputs.

## 🎛 App state & navigation (`App.jsx` explained)

- `App.jsx` implements a small state machine:
  - `currentScreen` (string) selects which page to render (e.g., 'home', 'teacher', 'secretary', 'result').
  - `resultType`, `resultTitle`, `resultMessage` store message data; when `currentScreen === 'result'` the `ResultMessage` component is shown.
  - Pages receive callbacks: `onGoBack`, `onShowResult`, `onSelectScreen` so they can change `currentScreen` without knowledge of the app's internals.

Why this design:
- Keeps routing simple for a small demo (no React Router). Navigation is explicit and easy to follow.

## 🎨 Styling & assets

- `src/index.css` — base theme, prefers dark by default but supports light scheme; system font stack and some resets.
- `src/App.css` — RTL layout, home screen and card styling, schedule cell styles.
- `src/pages/WeeklySchedulePage.css` — page-specific enhancements (hover effects, empty state styles).

## 🏁 How to run (development)

From repository root or this folder run:

```bash
cd stage5/sports-frontend
npm install
npm run dev
```

Notes:
- Backend must run at `http://localhost:3001` and expose the expected endpoints (`/api/*`). See `src/utils/apiService.js` for the exact endpoints used by the frontend.
- Linting: `npm run lint`
- Production build: `npm run build`


