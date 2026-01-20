// src/pages/RegisterStudentPage.jsx
import { useState, useEffect } from "react";
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
  const [parentMode, setParentMode] = useState("existing"); // 'existing' or 'new'
  const [newParentData, setNewParentData] = useState({
    firstName: "",
    lastName: "",
    email: "",
    phone: "",
    birthDate: "",
  });
  const [availableParents, setAvailableParents] = useState([]);
  const [loading, setLoading] = useState(false);
  const [parentsLoading, setParentsLoading] = useState(false);

  // Load available parents on component mount
  useEffect(() => {
    loadAvailableParents();
  }, []);

  const loadAvailableParents = async () => {
    setParentsLoading(true);
    try {
      const response = await fetch("http://localhost:3001/api/parents");
      if (!response.ok) {
        throw new Error("Failed to load parents");
      }
      const parents = await response.json();
      setAvailableParents(parents);
    } catch (error) {
      console.error("Error loading parents:", error);
      onShowResult("error", "שגיאה", "לא היה ניתן לטעון את רשימת ההורים");
    } finally {
      setParentsLoading(false);
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleNewParentChange = (e) => {
    const { name, value } = e.target;
    setNewParentData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    try {
      let parentIdToUse = formData.parentId;

      // If creating a new parent
      if (parentMode === "new") {
        // Validate new parent data
        if (
          !newParentData.firstName ||
          !newParentData.lastName ||
          !newParentData.birthDate
        ) {
          onShowResult(
            "error",
            "שגיאה בעת יצירת הורה",
            "חובה למלא: שם פרטי, שם משפחה ותאריך לידה",
          );
          setLoading(false);
          return;
        }

        // Create new parent
        try {
          const parentResult = await fetch(
            "http://localhost:3001/api/parents",
            {
              method: "POST",
              headers: {
                "Content-Type": "application/json",
              },
              body: JSON.stringify({
                firstName: newParentData.firstName,
                lastName: newParentData.lastName,
                email: newParentData.email,
                phone: newParentData.phone,
                birthDate: newParentData.birthDate,
              }),
            },
          );

          if (!parentResult.ok) {
            throw new Error("Failed to create parent");
          }

          const parentData = await parentResult.json();
          parentIdToUse = parentData.parentId;
        } catch (error) {
          onShowResult("error", "שגיאה בעת יצירת הורה", error.message);
          setLoading(false);
          return;
        }
      }

      // Create student with the parent ID
      const studentFormData = {
        ...formData,
        parentId: parentIdToUse,
      };

      const result = await apiService.createStudent(studentFormData);
      onShowResult(
        "success",
        "תלמיד נוצר בהצלחה",
        `מזהה התלמיד: ${result.studentId}`,
      );

      // Reset form
      setFormData({
        firstName: "",
        lastName: "",
        email: "",
        phone: "",
        birthDate: "",
        address: "",
        parentId: "",
      });
      setNewParentData({
        firstName: "",
        lastName: "",
        email: "",
        phone: "",
        birthDate: "",
      });
      setParentMode("existing");
      loadAvailableParents();
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
                <label className="form-label fw-bold">הורה</label>
                <div className="btn-group w-100 mb-3" role="group">
                  <input
                    type="radio"
                    className="btn-check"
                    name="parentMode"
                    id="parentModeExisting"
                    value="existing"
                    checked={parentMode === "existing"}
                    onChange={(e) => setParentMode(e.target.value)}
                    disabled={loading}
                  />
                  <label
                    className="btn btn-outline-info"
                    htmlFor="parentModeExisting"
                  >
                    <i className="bi bi-person-check me-2"></i>
                    בחר הורה קיים
                  </label>

                  <input
                    type="radio"
                    className="btn-check"
                    name="parentMode"
                    id="parentModeNew"
                    value="new"
                    checked={parentMode === "new"}
                    onChange={(e) => setParentMode(e.target.value)}
                    disabled={loading}
                  />
                  <label
                    className="btn btn-outline-info"
                    htmlFor="parentModeNew"
                  >
                    <i className="bi bi-person-plus me-2"></i>
                    צור הורה חדש
                  </label>
                </div>

                {/* Existing Parent Selection */}
                {parentMode === "existing" && (
                  <div>
                    {parentsLoading ? (
                      <div className="text-center">
                        <div
                          className="spinner-border spinner-border-sm"
                          role="status"
                        >
                          <span className="visually-hidden">טוען...</span>
                        </div>
                      </div>
                    ) : (
                      <select
                        name="parentId"
                        value={formData.parentId}
                        onChange={handleChange}
                        className="form-select form-select-lg"
                      >
                        <option value="">-- בחר הורה --</option>
                        {availableParents.map((parent) => (
                          <option key={parent.personid} value={parent.personid}>
                            {parent.first_name} {parent.last_name}
                            {parent.phone && ` (${parent.phone})`}
                          </option>
                        ))}
                      </select>
                    )}
                  </div>
                )}

                {/* New Parent Form */}
                {parentMode === "new" && (
                  <div className="card bg-light">
                    <div className="card-body">
                      <h6 className="card-title mb-3">פרטי הורה חדש</h6>

                      <div className="row g-3 mb-3">
                        <div className="col-md-6">
                          <label className="form-label fw-bold">
                            שם פרטי *
                          </label>
                          <input
                            type="text"
                            name="firstName"
                            value={newParentData.firstName}
                            onChange={handleNewParentChange}
                            className="form-control"
                            required
                            disabled={loading}
                          />
                        </div>
                        <div className="col-md-6">
                          <label className="form-label fw-bold">
                            שם משפחה *
                          </label>
                          <input
                            type="text"
                            name="lastName"
                            value={newParentData.lastName}
                            onChange={handleNewParentChange}
                            className="form-control"
                            required
                            disabled={loading}
                          />
                        </div>
                      </div>

                      <div className="row g-3 mb-3">
                        <div className="col-md-6">
                          <label className="form-label fw-bold">דוא״ל</label>
                          <input
                            type="email"
                            name="email"
                            value={newParentData.email}
                            onChange={handleNewParentChange}
                            className="form-control"
                            disabled={loading}
                          />
                        </div>
                        <div className="col-md-6">
                          <label className="form-label fw-bold">טלפון</label>
                          <input
                            type="tel"
                            name="phone"
                            value={newParentData.phone}
                            onChange={handleNewParentChange}
                            className="form-control"
                            disabled={loading}
                          />
                        </div>
                      </div>

                      <div className="mb-0">
                        <label className="form-label fw-bold">
                          תאריך לידה *
                        </label>
                        <input
                          type="date"
                          name="birthDate"
                          value={newParentData.birthDate}
                          onChange={handleNewParentChange}
                          className="form-control"
                          required
                          disabled={loading}
                        />
                      </div>
                    </div>
                  </div>
                )}
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
