// src/components/ScheduleDisplay.jsx
const ScheduleDisplay = ({ schedule }) => {
  const daysOfWeek = ["ראשון", "שני", "שלישי", "רביעי", "חמישי", "שישי", "שבת"];

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
                  {schedule[day] && schedule[day].length > 0 ? (
                    schedule[day].map((course, idx) => (
                      <div key={idx} className="class-card mb-2">
                        <strong>{course.className}</strong>
                        <div className="small text-muted">
                          רמה: {course.level}
                        </div>
                        {course.time && (
                          <div className="small">שעה: {course.time}</div>
                        )}
                        {course.location && (
                          <div className="small">מקום: {course.location}</div>
                        )}
                        {course.teacher && (
                          <div className="small">מורה: {course.teacher}</div>
                        )}
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
