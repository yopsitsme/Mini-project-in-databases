// src/pages/SecretaryPage.jsx
export const SecretaryPage = ({ onGoHome, onSelectScreen }) => (
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
          </div>
        </div>
      </div>
    </div>
  </div>
);
