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
        throw new Error(`Failed to fetch weekly schedule: ${errorText}`);
      }
      const scheduleData = await scheduleResponse.json();
      console.log("Schedule data received:", scheduleData);
      setSchedule(scheduleData || []);

      // Fetch all courses
      const coursesResponse = await fetch(
        "http://localhost:3001/api/schedule/courses",
      );
      if (!coursesResponse.ok) {
        const errorText = await coursesResponse.text();
        throw new Error(`Failed to fetch courses: ${errorText}`);
      }
      const coursesData = await coursesResponse.json();
      console.log("Courses data received:", coursesData);
      setCourses(coursesData || []);
    } catch (err) {
      setError(err.message);
      console.error("Error fetching data:", err);
    } finally {
      setLoading(false);
    }
  };

  // Group schedule by day of week
  const scheduleByDay = {};
  schedule.forEach((item) => {
    const day = item.day_of_week;
    if (!scheduleByDay[day]) {
      scheduleByDay[day] = [];
    }
    scheduleByDay[day].push(item);
  });

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
              <div className="row g-3">
                {[1, 2, 3, 4, 5, 6, 7].map((day) => (
                  <div key={day} className="col-md-6 col-lg-4">
                    <div className="card border-info h-100">
                      <div className="card-header bg-light">
                        <h5 className="mb-0 text-info">
                          יום {getDayName(day)}
                        </h5>
                      </div>
                      <div className="card-body">
                        {scheduleByDay[day] && scheduleByDay[day].length > 0 ? (
                          <div className="table-responsive">
                            <table className="table table-sm table-hover">
                              <tbody>
                                {scheduleByDay[day].map((item, idx) => (
                                  <tr key={idx}>
                                    <td>
                                      <small className="text-muted">
                                        {item.start_hour}:00 -{" "}
                                        {item.end_time
                                          ? new Date(item.end_time).getHours()
                                          : ""}
                                        {item.end_time
                                          ? ":" +
                                            new Date(item.end_time)
                                              .getMinutes()
                                              .toString()
                                              .padStart(2, "0")
                                          : ""}
                                      </small>
                                      <br />
                                      <strong className="text-primary">
                                        {item.classes_offered || "שיעור"}
                                      </strong>
                                      <br />
                                      <small className="text-success">
                                        {item.groups_at_time || 0} קבוצ
                                        {item.groups_at_time === 1 ? "ה" : "ות"}
                                      </small>
                                      <br />
                                      <small className="text-warning">
                                        {item.total_students || 0} תלמידים
                                      </small>
                                    </td>
                                  </tr>
                                ))}
                              </tbody>
                            </table>
                          </div>
                        ) : (
                          <p className="text-muted text-center mb-0">
                            אין שיעורים
                          </p>
                        )}
                      </div>
                    </div>
                  </div>
                ))}
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
