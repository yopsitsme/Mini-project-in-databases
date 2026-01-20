// src/components/ScheduleDisplay.jsx
import { dayMapping, initializeSchedule } from "../utils/dayMapping";

const ScheduleDisplay = ({ schedule, showLevel = true }) => {
  const daysOfWeek = ["ראשון", "שני", "שלישי", "רביעי", "חמישי", "שישי", "שבת"];

  // Normalize schedule so component works with either Hebrew keys or English keys
  const normalizeSchedule = (raw) => {
    const base = initializeSchedule();
    if (!raw) return base;

    // If raw already uses Hebrew keys, merge and return
    const hebrewKeys = Object.keys(base);
    const hasHebrew = hebrewKeys.some((k) => Array.isArray(raw[k]) && raw[k].length > 0);
    if (hasHebrew) return { ...base, ...raw };

    // Otherwise try to map English day keys to Hebrew
    const mapped = { ...base };
    Object.keys(raw).forEach((key) => {
      // Normalize capitalization (e.g. sunday, Sunday)
      const cap = key.charAt(0).toUpperCase() + key.slice(1).toLowerCase();
      const heb = dayMapping[key] || dayMapping[cap];
      if (heb) {
        mapped[heb] = raw[key];
      }
    });

    return mapped;
  };

  const normalized = normalizeSchedule(schedule);

  return (
    <div className="table-responsive mt-3">
      <table className="table table-bordered">
        <thead>
          <tr className="table-light">
            {daysOfWeek.map((day) => (
              <th key={day} className="text-center">
                {day}
              </th>
            ))}
          </tr>
        </thead>
        <tbody>
          <tr>
            {daysOfWeek.map((day) => (
              <td key={day} className="day-cell">
                <div className="classes-container">
                  {normalized[day] && normalized[day].length > 0 ? (
                    normalized[day].map((course, idx) => (
                      <div key={idx} className="class-card mb-2">
                        <strong>{course.className}</strong>
                        {showLevel && (
                          <div className="small text-muted">רמה: {course.level}</div>
                        )}
                        {course.time && <div className="small">שעה: {course.time}</div>}
                        {course.location && <div className="small">מקום: {course.location}</div>}
                        {course.teacher && <div className="small">מורה: {course.teacher}</div>}
                      </div>
                    ))
                  ) : (
                    <div className="text-muted small">אין שיעורים</div>
                  )}
                </div>
              </td>
            ))}
          </tr>
        </tbody>
      </table>
    </div>
  );
};

export default ScheduleDisplay;
