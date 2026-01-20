// src/pages/RevenuePage.jsx
import { useState } from "react";
import apiService from "../utils/apiService";

export const RevenuePage = ({ onGoBack }) => {
  const [month, setMonth] = useState("");
  const [year, setYear] = useState("");
  const [revenueReport, setRevenueReport] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const handleRevenueSubmit = async () => {
    setLoading(true);
    setError("");
    try {
      const reportData = await apiService.getMonthlyRevenue(year, month);
      setRevenueReport(reportData.report);
    } catch (err) {
      setError("Error fetching report: " + err.message);
    }
    setLoading(false);
  };

  return (
    <div className="screen-container bg-warning-subtle">
      <div className="container py-5">
        <button onClick={onGoBack} className="btn btn-secondary mb-4">
          <i className="bi bi-arrow-right me-2"></i>
          חזרה
        </button>

        <div className="card shadow-lg">
          <div className="card-header bg-warning">
            <h2 className="mb-0">
              <i className="bi bi-graph-up me-2"></i>
              דוח הכנסות חודשי
            </h2>
          </div>
          <div className="card-body">
            <div className="row g-3 mb-4">
              <div className="col-md-6">
                <label className="form-label fw-bold">חודש (1-12)</label>
                <input
                  type="number"
                  min="1"
                  max="12"
                  value={month}
                  onChange={(e) => setMonth(e.target.value)}
                  className="form-control form-control-lg"
                  placeholder="חודש"
                />
              </div>
              <div className="col-md-6">
                <label className="form-label fw-bold">שנה</label>
                <input
                  type="number"
                  min="2000"
                  max="2100"
                  value={year}
                  onChange={(e) => setYear(e.target.value)}
                  className="form-control form-control-lg"
                  placeholder="שנה"
                />
              </div>
            </div>

            <button
              onClick={handleRevenueSubmit}
              disabled={loading || !month || !year}
              className="btn btn-warning btn-lg w-100"
            >
              {loading ? (
                <>
                  <span className="spinner-border spinner-border-sm me-2"></span>
                  טוען...
                </>
              ) : (
                <>
                  <i className="bi bi-file-earmark-text me-2"></i>
                  הצג דוח
                </>
              )}
            </button>

            {error && (
              <div className="alert alert-danger mt-4">
                <i className="bi bi-exclamation-triangle me-2"></i>
                {error}
              </div>
            )}

            {revenueReport && (
              <div className="alert alert-success mt-4">
                <h4 className="alert-heading">דוח הכנסות:</h4>
                <pre className="mb-0">{revenueReport}</pre>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};
