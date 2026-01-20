// src/pages/RegisterStudentPage.jsx
import { useState } from "react";
import apiService from "../utils/apiService";

export const RegisterStudentPage = ({ onGoBack, onShowResult }) => {
  const [formData, setFormData] = useState({
    firstName: "",
    lastName: "",
    email: "",
    phone: "",
    birthDate: "",
    address: "",
    parentId: "",
  });
  const [loading, setLoading] = useState(false);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    try {
      const result = await apiService.createStudent(formData);
      onShowResult(
        "success",
        "תלמיד נוצר בהצלחה",
        `מזהה התלמיד: ${result.studentId}`,
      );
      setFormData({
        firstName: "",
        lastName: "",
        email: "",
        phone: "",
        birthDate: "",
        address: "",
        parentId: "",
      });
    } catch (error) {
      onShowResult("error", "שגיאה ברישום", error.message);
    }

    setLoading(false);
  };

  return (
    <div className="screen-container bg-info-subtle">
      <div className="container py-5">
        <button onClick={onGoBack} className="btn btn-secondary mb-4">
          <i className="bi bi-arrow-right me-2"></i>
          חזרה
        </button>

        <div className="card shadow-lg">
          <div className="card-header bg-info">
            <h2 className="mb-0">
              <i className="bi bi-person-plus-fill me-2"></i>
              רישום תלמיד חדש
            </h2>
          </div>
          <div className="card-body">
            <form onSubmit={handleSubmit}>
              <div className="row g-3 mb-4">
                <div className="col-md-6">
                  <label className="form-label fw-bold">שם פרטי *</label>
                  <input
                    type="text"
                    name="firstName"
                    value={formData.firstName}
                    onChange={handleChange}
                    className="form-control form-control-lg"
                    required
                  />
                </div>
                <div className="col-md-6">
                  <label className="form-label fw-bold">שם משפחה *</label>
                  <input
                    type="text"
                    name="lastName"
                    value={formData.lastName}
                    onChange={handleChange}
                    className="form-control form-control-lg"
                    required
                  />
                </div>
              </div>

              <div className="row g-3 mb-4">
                <div className="col-md-6">
                  <label className="form-label fw-bold">דוא״ל</label>
                  <input
                    type="email"
                    name="email"
                    value={formData.email}
                    onChange={handleChange}
                    className="form-control form-control-lg"
                  />
                </div>
                <div className="col-md-6">
                  <label className="form-label fw-bold">טלפון</label>
                  <input
                    type="tel"
                    name="phone"
                    value={formData.phone}
                    onChange={handleChange}
                    className="form-control form-control-lg"
                  />
                </div>
              </div>

              <div className="row g-3 mb-4">
                <div className="col-md-6">
                  <label className="form-label fw-bold">תאריך לידה *</label>
                  <input
                    type="date"
                    name="birthDate"
                    value={formData.birthDate}
                    onChange={handleChange}
                    className="form-control form-control-lg"
                    required
                  />
                </div>
                <div className="col-md-6">
                  <label className="form-label fw-bold">כתובת</label>
                  <input
                    type="text"
                    name="address"
                    value={formData.address}
                    onChange={handleChange}
                    className="form-control form-control-lg"
                  />
                </div>
              </div>

              <div className="mb-4">
                <label className="form-label fw-bold">מזהה הורה</label>
                <input
                  type="number"
                  name="parentId"
                  value={formData.parentId}
                  onChange={handleChange}
                  className="form-control form-control-lg"
                />
              </div>

              <button
                type="submit"
                disabled={loading}
                className="btn btn-info btn-lg w-100"
              >
                {loading ? (
                  <>
                    <span className="spinner-border spinner-border-sm me-2"></span>
                    שומר...
                  </>
                ) : (
                  <>
                    <i className="bi bi-save me-2"></i>
                    שמור תלמיד
                  </>
                )}
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  );
};
