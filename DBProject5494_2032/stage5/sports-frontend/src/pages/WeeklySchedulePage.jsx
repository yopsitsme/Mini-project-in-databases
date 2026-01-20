// src/pages/WeeklySchedulePage.jsx
import { useState, useEffect } from "react";
import "./WeeklySchedulePage.css";

export const WeeklySchedulePage = ({ onGoBack }) => {
  const [schedule, setSchedule] = useState([]);
  const [courses, setCourses] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  // Days of week in Hebrew and English
  const daysOfWeek = [
    { he: "ראשון", en: "Sunday", dayNum: 1 },
    { he: "שני", en: "Monday", dayNum: 2 },
    { he: "שלישי", en: "Tuesday", dayNum: 3 },
    { he: "רביעי", en: "Wednesday", dayNum: 4 },
    { he: "חמישי", en: "Thursday", dayNum: 5 },
    { he: "שישי", en: "Friday", dayNum: 6 },
    { he: "שבת", en: "Saturday", dayNum: 7 },
  ];

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      setLoading(true);
      setError("");

      // Fetch weekly schedule
      const scheduleResponse = await fetch(
        "http://localhost:3001/api/schedule/weekly-schedule",
      );
      if (!scheduleResponse.ok) {
        const errorText = await scheduleResponse.text();
        throw new Error(
          `Failed to fetch weekly schedule: ${scheduleResponse.status} - ${errorText}`,
        );
      }
      const scheduleData = await scheduleResponse.json();
      console.log("Schedule data received:", scheduleData);
      console.log(
        "Schedule data structure:",
        scheduleData.length > 0 ? scheduleData[0] : "empty",
      );
      setSchedule(scheduleData || []);

      // Fetch all courses
      const coursesResponse = await fetch(
        "http://localhost:3001/api/schedule/courses",
      );
      if (!coursesResponse.ok) {
        const errorText = await coursesResponse.text();
        throw new Error(
          `Failed to fetch courses: ${coursesResponse.status} - ${errorText}`,
        );
      }
      const coursesData = await coursesResponse.json();
      console.log("Courses data received:", coursesData);
      setCourses(coursesData || []);
    } catch (err) {
      console.error("Error in fetchData:", err);
      setError(
        err.message ||
          "Failed to connect to the server. Please make sure the backend is running on http://localhost:3001",
      );
    } finally {
      setLoading(false);
    }
  };

  // Group schedule by day of week - convert day_of_week to number if needed
  const scheduleByDay = {};
  // Initialize all days
  daysOfWeek.forEach((day) => {
    scheduleByDay[day.dayNum] = [];
  });

  // Populate with actual schedule data
  schedule.forEach((item) => {
    const day = parseInt(item.day_of_week) || item.day_of_week;
    console.log(
      "Processing item with day_of_week:",
      item.day_of_week,
      "parsed as:",
      day,
      "item:",
      item,
    );
    if (scheduleByDay[day]) {
      scheduleByDay[day].push(item);
    } else {
      console.warn(
        "No matching day found for:",
        day,
        "Available days:",
        Object.keys(scheduleByDay),
      );
    }
  });
  console.log("Final schedule grouped by day:", scheduleByDay);

  return (
    <div className="screen-container bg-info-subtle">
      <div className="container py-5">
        <button onClick={onGoBack} className="btn btn-secondary mb-4">
          <i className="bi bi-arrow-right me-2"></i>
          חזרה
        </button>

        {error && (
          <div className="alert alert-danger" role="alert">
            {error}
          </div>
        )}

        <div className="card shadow-lg mb-5">
          <div className="card-header bg-info">
            <h2 className="mb-0">
              <i className="bi bi-calendar-week me-2"></i>
              לוח זמנים שבועי
            </h2>
          </div>
          <div className="card-body">
            {loading ? (
              <div className="text-center">
                <div className="spinner-border" role="status">
                  <span className="visually-hidden">Loading...</span>
                </div>
              </div>
            ) : (
              <div className="table-responsive">
                <table className="table table-bordered">
                  <thead>
                    <tr className="table-light">
                      {daysOfWeek.map((day) => (
                        <th key={day.dayNum} className="text-center">
                          {day.he}
                          <br />
                          <small className="text-muted">{day.en}</small>
                        </th>
                      ))}
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      {daysOfWeek.map((day) => (
                        <td key={day.dayNum} className="day-cell">
                          <div className="classes-container">
                            {scheduleByDay[day.dayNum] &&
                            scheduleByDay[day.dayNum].length > 0 ? (
                              scheduleByDay[day.dayNum].map((item, idx) => (
                                <div key={idx} className="class-card mb-2">
                                  <strong className="text-primary">
                                    {item.classes_offered}
                                  </strong>
                                  <div className="small text-muted">
                                    שעה: {item.start_hour}:00
                                  </div>
                                  <div className="small text-success">
                                    קבוצות: {item.groups_at_time}
                                  </div>
                                  <div className="small text-warning">
                                    תלמידים: {item.total_students}
                                  </div>
                                </div>
                              ))
                            ) : (
                              <div className="text-muted small">
                                אין שיעורים
                              </div>
                            )}
                          </div>
                        </td>
                      ))}
                    </tr>
                  </tbody>
                </table>
              </div>
            )}
          </div>
        </div>

        <div className="card shadow-lg">
          <div className="card-header bg-success">
            <h3 className="mb-0">
              <i className="bi bi-list-check me-2"></i>
              רשימת כל הקורסים
            </h3>
          </div>
          <div className="card-body">
            {loading ? (
              <div className="text-center">
                <div className="spinner-border" role="status">
                  <span className="visually-hidden">Loading...</span>
                </div>
              </div>
            ) : courses.length > 0 ? (
              <div className="table-responsive">
                <table className="table table-striped table-hover">
                  <thead className="table-success">
                    <tr>
                      <th>שם הקורס</th>
                      <th>מספר קבוצות</th>
                      <th>סה"כ תלמידים</th>
                    </tr>
                  </thead>
                  <tbody>
                    {courses.map((course) => (
                      <tr key={course.id}>
                        <td>
                          <strong>{course.course_name}</strong>
                        </td>
                        <td>
                          <span className="badge bg-info">
                            {course.total_groups || 0}
                          </span>
                        </td>
                        <td>
                          <span className="badge bg-success">
                            {course.total_students || 0}
                          </span>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            ) : (
              <p className="text-muted text-center">אין קורסים זמינים</p>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};
