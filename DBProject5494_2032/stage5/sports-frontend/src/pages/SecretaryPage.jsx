// src/pages/SecretaryPage.jsx
import { useState } from "react";

export const SecretaryPage = ({ onGoHome, onSelectScreen }) => {
  const [busyStudents, setBusyStudents] = useState(null);
  const [loadingBusy, setLoadingBusy] = useState(false);
  const [busyError, setBusyError] = useState("");

  const fetchBusyStudents = async () => {
    try {
      setLoadingBusy(true);
      setBusyError("");
      const res = await fetch("http://localhost:3001/api/students/busy-active");
      if (!res.ok) {
        const txt = await res.text();
        throw new Error(`${res.status} - ${txt}`);
      }
      const data = await res.json();
      setBusyStudents(data);
    } catch (err) {
      console.error("Failed to load busy students:", err);
      setBusyError(err.message || "Failed to load data");
    } finally {
      setLoadingBusy(false);
    }
  };

  return (
    <div className="screen-container bg-warning-subtle">
      <div className="container py-5">
        <button onClick={onGoHome} className="btn btn-secondary mb-4">
          <i className="bi bi-arrow-right me-2"></i>
          חזרה
        </button>

        <div className="card shadow-lg">
          <div className="card-header bg-warning">
            <h2 className="mb-0">
              <i className="bi bi-briefcase-fill me-2"></i>
              מזכירות - תפריט ראשי
            </h2>
          </div>
          <div className="card-body">
            <div className="row g-4">
              <div className="col-md-4">
                <button
                  onClick={() => onSelectScreen("revenue")}
                  className="btn btn-warning btn-lg w-100 menu-btn"
                >
                  <i className="bi bi-currency-dollar mb-3"></i>
                  <h4>דוח הכנסות חודשי</h4>
                </button>
              </div>

              <div className="col-md-4">
                <button
                  onClick={() => onSelectScreen("register-student")}
                  className="btn btn-info btn-lg w-100 menu-btn"
                >
                  <i className="bi bi-person-plus-fill mb-3"></i>
                  <h4>רישום תלמיד</h4>
                </button>
              </div>

              <div className="col-md-4">
                <button
                  onClick={() => onSelectScreen("register-teacher")}
                  className="btn btn-success btn-lg w-100 menu-btn"
                >
                  <i className="bi bi-person-badge-fill mb-3"></i>
                  <h4>רישום מורה</h4>
                </button>
              </div>

              <div className="col-md-4">
                <button
                  onClick={() => onSelectScreen("enroll-student")}
                  className="btn btn-primary btn-lg w-100 menu-btn"
                >
                  <i className="bi bi-person-check-fill mb-3"></i>
                  <h4>הרשמת תלמיד לקורסים</h4>
                </button>
              </div>

              <div className="col-md-4">
                <button
                  onClick={() => onSelectScreen("delete-student-from-course")}
                  className="btn btn-danger btn-lg w-100 menu-btn"
                >
                  <i className="bi bi-person-x-fill mb-3"></i>
                  <h4>הסרת תלמיד מקורסים</h4>
                </button>
              </div>

              <div className="col-md-4">
                <button
                  onClick={() => onSelectScreen("weekly-schedule")}
                  className="btn btn-info btn-lg w-100 menu-btn"
                >
                  <i className="bi bi-calendar-week mb-3"></i>
                  <h4>לוח זמנים שבועי</h4>
                </button>
              </div>

              {/* Busy active students button */}
              <div className="col-12 mt-4">
                <button
                  onClick={fetchBusyStudents}
                  className="btn btn-outline-primary"
                  disabled={loadingBusy}
                >
                  {loadingBusy ? (
                    <span className="spinner-border spinner-border-sm me-2" />
                  ) : null}
                  הצג תלמידים פעילים ( בקורסים רבים )
                </button>
              </div>

              {busyError && (
                <div className="col-12 mt-3 alert alert-danger">{busyError}</div>
              )}

              {busyStudents && (
                <div className="col-12 mt-3">
                  <div className="table-responsive">
                    <table className="table table-sm table-striped">
                      <thead>
                        <tr>
                          <th>שם תלמיד</th>
                          <th>אימייל</th>
                          <th>טלפון</th>
                          <th>כתובת</th>
                          <th>גיל</th>
                          <th>מספר קורסים</th>
                          <th>סך הכל דמי הרשמה</th>
                        </tr>
                      </thead>
                      <tbody>
                        {busyStudents.map((s, idx) => (
                          <tr key={idx}>
                            <td>{s.student_name}</td>
                            <td>{s.email}</td>
                            <td>{s.phone}</td>
                            <td>{s.addres || s.address || ""}</td>
                            <td>{s.age}</td>
                            <td>{s.classes_enrolled}</td>
                            <td>{s.total_fees}</td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
