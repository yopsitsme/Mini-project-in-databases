// src/pages/HomePage.jsx
export const HomePage = ({ onSelectScreen }) => (
  <div className="home-screen">
    <div className="container">
      <div className="card home-card shadow-lg">
        <div className="card-body text-center">
          <div className="mb-4">
            <i className="bi bi-trophy-fill home-icon"></i>
          </div>
          <h1 className="display-4 mb-3">מערכת ניהול ספורט</h1>
          <p className="lead text-muted mb-5">בחר את סוג המשתמש להמשך</p>

          <div className="row g-4">
            <div className="col-md-4">
              <button
                onClick={() => onSelectScreen("teacher")}
                className="btn btn-primary btn-lg w-100 menu-btn"
              >
                <i className="bi bi-person-circle mb-3"></i>
                <h3>מורה</h3>
              </button>
            </div>

            <div className="col-md-4">
              <button
                onClick={() => onSelectScreen("student")}
                className="btn btn-success btn-lg w-100 menu-btn"
              >
                <i className="bi bi-people-fill mb-3"></i>
                <h3>תלמיד</h3>
              </button>
            </div>

            <div className="col-md-4">
              <button
                onClick={() => onSelectScreen("secretary")}
                className="btn btn-warning btn-lg w-100 menu-btn"
              >
                <i className="bi bi-calendar-check-fill mb-3"></i>
                <h3>מזכירות</h3>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
);
