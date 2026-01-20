// src/components/ResultMessage.jsx
const ResultMessage = ({ type, title, message, onClose }) => (
  <div
    className="screen-container"
    style={{ background: type === "success" ? "#d4edda" : "#f8d7da" }}
  >
    <div className="container py-5">
      <div
        className="card shadow-lg"
        style={{
          borderColor: type === "success" ? "#28a745" : "#dc3545",
          borderWidth: "3px",
        }}
      >
        <div className="card-body text-center py-5">
          {type === "success" ? (
            <>
              <i
                className="bi bi-check-circle"
                style={{ fontSize: "4rem", color: "#28a745" }}
              ></i>
              <h2 className="mt-4 mb-2" style={{ color: "#28a745" }}>
                {title}
              </h2>
              <p className="lead text-muted mb-4">{message}</p>
              <div className="alert alert-success mb-4">
                <i className="bi bi-info-circle me-2"></i>
                הנתונים נשמרו בהצלחה במערכת!
              </div>
            </>
          ) : (
            <>
              <i
                className="bi bi-exclamation-circle"
                style={{ fontSize: "4rem", color: "#dc3545" }}
              ></i>
              <h2 className="mt-4 mb-2" style={{ color: "#dc3545" }}>
                {title || "שגיאה"}
              </h2>
              <p className="lead text-muted mb-4">{message}</p>
              <div className="alert alert-danger mb-4">
                <i className="bi bi-exclamation-triangle me-2"></i>
                אנא נסה שוב או בדוק את הנתונים שלך
              </div>
            </>
          )}

          <button
            onClick={onClose}
            className="btn btn-lg"
            style={{
              backgroundColor: type === "success" ? "#28a745" : "#dc3545",
              color: "white",
            }}
          >
            <i className="bi bi-house-fill me-2"></i>
            חזרה לדף הבית
          </button>
        </div>
      </div>
    </div>
  </div>
);

export default ResultMessage;
