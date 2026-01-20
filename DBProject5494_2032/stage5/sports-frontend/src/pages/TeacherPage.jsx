// src/pages/TeacherPage.jsx
import { useState } from "react";
import apiService from "../utils/apiService";
import { dayMapping, initializeSchedule } from "../utils/dayMapping";
import ScheduleDisplay from "../components/ScheduleDisplay";

export const TeacherPage = ({ onGoHome, onShowResult }) => {
  const [teacherId, setTeacherId] = useState("");
  const [teacherWorkload, setTeacherWorkload] = useState(null);
  const [teacherSchedule, setTeacherSchedule] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const handleTeacherSubmit = async () => {
    setLoading(true);
    setError("");
    try {
      const workloadData = await apiService.getTeacherWorkload(teacherId);
      setTeacherWorkload(workloadData.workload);

      const scheduleData = await apiService.getTeacherSchedule(teacherId);
      setTeacherSchedule(scheduleData.schedule);
    } catch (err) {
      setError("Error fetching data: " + err.message);
    }
    setLoading(false);
  };

  return (
    <div className="screen-container bg-primary-subtle">
      <div className="container py-5">
        <button onClick={onGoHome} className="btn btn-secondary mb-4">
          <i className="bi bi-arrow-right me-2"></i>
          חזרה
        </button>

        <div className="card shadow-lg">
          <div className="card-header bg-primary">
            <h2 className="mb-0">
              <i className="bi bi-person-circle me-2"></i>
              מערכת מורה
            </h2>
          </div>
          <div className="card-body">
            <div className="mb-4">
              <label className="form-label fw-bold">מזהה מורה</label>
              <input
                type="number"
                value={teacherId}
                onChange={(e) => setTeacherId(e.target.value)}
                className="form-control form-control-lg"
                placeholder="הזן מזהה מורה"
              />
            </div>

            <button
              onClick={handleTeacherSubmit}
              disabled={loading || !teacherId}
              className="btn btn-primary btn-lg w-100"
            >
              {loading ? (
                <>
                  <span className="spinner-border spinner-border-sm me-2"></span>
                  טוען...
                </>
              ) : (
                <>
                  <i className="bi bi-search me-2"></i>
                  הצג פרטים
                </>
              )}
            </button>

            {error && (
              <div className="alert alert-danger mt-4">
                <i className="bi bi-exclamation-triangle me-2"></i>
                {error}
              </div>
            )}

            {teacherWorkload !== null && (
              <div className="alert alert-info mt-4">
                <h4>עומס עבודה של המורה:</h4>
                <p className="mb-0">{teacherWorkload}</p>
              </div>
            )}

            {teacherSchedule && (
              <div className="mt-4">
                <h4>לוח הזמנים של המורה:</h4>
                <ScheduleDisplay schedule={teacherSchedule} />
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};
