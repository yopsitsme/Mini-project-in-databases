// src/pages/StudentPage.jsx
import { useState } from "react";
import apiService from "../utils/apiService";
import ScheduleDisplay from "../components/ScheduleDisplay";

export const StudentPage = ({ onGoHome }) => {
  const [studentId, setStudentId] = useState("");
  const [studentSchedule, setStudentSchedule] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const handleStudentSubmit = async () => {
    setLoading(true);
    setError("");
    try {
      const scheduleData = await apiService.getStudentSchedule(studentId);
      setStudentSchedule(scheduleData.schedule);
    } catch (err) {
      setError("Error fetching data: " + err.message);
    }
    setLoading(false);
  };

  return (
    <div className="screen-container bg-success-subtle">
      <div className="container py-5">
        <button onClick={onGoHome} className="btn btn-secondary mb-4">
          <i className="bi bi-arrow-right me-2"></i>
          חזרה
        </button>

        <div className="card shadow-lg">
          <div className="card-header bg-success">
            <h2 className="mb-0">
              <i className="bi bi-people-fill me-2"></i>
              מערכת תלמיד
            </h2>
          </div>
          <div className="card-body">
            <div className="mb-4">
              <label className="form-label fw-bold">מזהה תלמיד</label>
              <input
                type="number"
                value={studentId}
                onChange={(e) => setStudentId(e.target.value)}
                className="form-control form-control-lg"
                placeholder="הזן מזהה תלמיד"
              />
            </div>

            <button
              onClick={handleStudentSubmit}
              disabled={loading || !studentId}
              className="btn btn-success btn-lg w-100"
            >
              {loading ? (
                <>
                  <span className="spinner-border spinner-border-sm me-2"></span>
                  טוען...
                </>
              ) : (
                <>
                  <i className="bi bi-search me-2"></i>
                  הצג לוח זמנים
                </>
              )}
            </button>

            {error && (
              <div className="alert alert-danger mt-4">
                <i className="bi bi-exclamation-triangle me-2"></i>
                {error}
              </div>
            )}

            {studentSchedule && (
              <div className="mt-4">
                <h4>לוח הזמנים של התלמיד:</h4>
                <ScheduleDisplay schedule={studentSchedule} />
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};
