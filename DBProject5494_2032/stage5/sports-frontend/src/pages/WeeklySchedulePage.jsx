// src/pages/WeeklySchedulePage.jsx
import { useState, useEffect } from "react";
import "./WeeklySchedulePage.css";
import ScheduleDisplay from "../components/ScheduleDisplay";
import { dayMapping, initializeSchedule } from "../utils/dayMapping";

export const WeeklySchedulePage = ({ onGoBack }) => {
  const [schedule, setSchedule] = useState(null);
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

      // Normalize schedule into the same shape used by Student/Teacher pages
      const mapped = initializeSchedule();

      // If backend already returned a mapped schedule object
      if (scheduleData && scheduleData.schedule) {
        setSchedule({ ...mapped, ...scheduleData.schedule });
      } else if (Array.isArray(scheduleData)) {
        // scheduleData is an array of items — map into Hebrew-day keys
        scheduleData.forEach((item) => {
          let dayKey = null;

          // Try numeric day (1-7)
          const dayNum = parseInt(item.day_of_week);
          if (!isNaN(dayNum)) {
            const dayObj = daysOfWeek.find((d) => d.dayNum === dayNum);
            dayKey = dayObj ? dayObj.he : null;
          }

          // Try English name mapping
          if (!dayKey && item.day_of_week) {
            const cap =
              item.day_of_week.charAt(0).toUpperCase() +
              item.day_of_week.slice(1).toLowerCase();
            dayKey = dayMapping[item.day_of_week] || dayMapping[cap] || null;
          }

          if (!dayKey) return;

          mapped[dayKey].push({
            className: item.classes_offered || item.class_name || item.course_name,
            level: item.level || null,
            time: item.start_hour ? `${item.start_hour}:00` : item.time || null,
            location: item.location || null,
            teacher: item.teacher_name || null,
            groupsAtTime: item.groups_at_time || null,
            totalStudents: item.total_students || null,
          });
        });

        setSchedule(mapped);
      } else {
        setSchedule(mapped);
      }

      // no courses list needed for weekly schedule page
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

  // Weekly schedule is normalized into a Hebrew-keyed object and
  // rendered by `ScheduleDisplay`. No further grouping needed here.

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
              <div>
                {schedule ? (
                  <ScheduleDisplay schedule={schedule} showLevel={false} />
                ) : (
                  <div className="text-center text-muted">אין נתונים להצגה</div>
                )}
              </div>
            )}
          </div>
        </div>

        {/* courses list removed — weekly schedule page shows only the schedule table */}
      </div>
    </div>
  );
};
