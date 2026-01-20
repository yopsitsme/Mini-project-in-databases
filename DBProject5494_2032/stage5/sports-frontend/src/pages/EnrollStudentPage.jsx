// src/pages/EnrollStudentPage.jsx
import { useState, useEffect } from "react";

export const EnrollStudentPage = ({ onGoBack, onShowResult }) => {
  const [studentId, setStudentId] = useState("");
  const [availableCourses, setAvailableCourses] = useState([]);
  const [selectedCourses, setSelectedCourses] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [coursesLoaded, setCoursesLoaded] = useState(false);

  // Fetch available courses
  const loadAvailableCourses = async () => {
    try {
      setLoading(true);
      setError("");
      const response = await fetch("http://localhost:3001/api/groups");
      if (!response.ok) {
        throw new Error("Failed to load courses");
      }
      const groups = await response.json();

      // Filter groups that have available space
      const availableGroups = groups.filter(
        (group) =>
          group.current_amount < group.capacity && group.status !== "FULL",
      );

      setAvailableCourses(availableGroups);
      setCoursesLoaded(true);
    } catch (err) {
      setError("Error loading courses: " + err.message);
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  // Load courses on component mount
  useEffect(() => {
    loadAvailableCourses();
  }, []);

  // Handle course selection
  const handleCourseToggle = (groupId) => {
    setSelectedCourses((prev) =>
      prev.includes(groupId)
        ? prev.filter((id) => id !== groupId)
        : [...prev, groupId],
    );
  };

  // Handle enrollment
  const handleEnrollment = async (e) => {
    e.preventDefault();

    if (!studentId || studentId.trim() === "") {
      setError("Please enter a student ID");
      return;
    }

    if (selectedCourses.length === 0) {
      setError("Please select at least one course");
      return;
    }

    try {
      setLoading(true);
      setError("");

      const response = await fetch(
        "http://localhost:3001/api/students/enroll",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            studentId: parseInt(studentId),
            groupIds: selectedCourses,
          }),
        },
      );

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || "Enrollment failed");
      }

      onShowResult(
        "success",
        "הרשמה הושלמה בהצלחה",
        `תלמיד ${studentId} נרשם לקורסים בהצלחה`,
      );

      // Reset form
      setStudentId("");
      setSelectedCourses([]);
    } catch (err) {
      setError("Error during enrollment: " + err.message);
      console.error(err);
    } finally {
      setLoading(false);
    }
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
              <i className="bi bi-person-check-fill me-2"></i>
              הרשמת תלמיד לקורסים
            </h2>
          </div>
          <div className="card-body">
            <form onSubmit={handleEnrollment}>
              {/* Student ID Input */}
              <div className="mb-4">
                <label htmlFor="studentId" className="form-label">
                  <strong>מזהה תלמיד:</strong>
                </label>
                <input
                  type="number"
                  id="studentId"
                  className="form-control"
                  value={studentId}
                  onChange={(e) => setStudentId(e.target.value)}
                  placeholder="הזן מזהה תלמיד"
                  disabled={loading}
                />
              </div>

              {/* Error Message */}
              {error && (
                <div
                  className="alert alert-danger alert-dismissible fade show"
                  role="alert"
                >
                  {error}
                  <button
                    type="button"
                    className="btn-close"
                    onClick={() => setError("")}
                  ></button>
                </div>
              )}

              {/* Available Courses */}
              <div className="mb-4">
                <h4 className="mb-3">
                  <strong>קורסים זמינים:</strong>
                </h4>

                {!coursesLoaded && loading ? (
                  <div className="text-center">
                    <div className="spinner-border" role="status">
                      <span className="visually-hidden">טוען...</span>
                    </div>
                  </div>
                ) : availableCourses.length === 0 ? (
                  <div className="alert alert-warning">
                    לא נמצאו קורסים זמינים
                  </div>
                ) : (
                  <div className="row g-3">
                    {availableCourses.map((course) => (
                      <div key={course.groupid} className="col-md-6">
                        <div
                          className={`card h-100 cursor-pointer ${
                            selectedCourses.includes(course.groupid)
                              ? "border-primary border-2 bg-light"
                              : ""
                          }`}
                          onClick={() => handleCourseToggle(course.groupid)}
                          style={{ cursor: "pointer" }}
                        >
                          <div className="card-body">
                            <div className="form-check">
                              <input
                                className="form-check-input"
                                type="checkbox"
                                id={`course-${course.groupid}`}
                                checked={selectedCourses.includes(
                                  course.groupid,
                                )}
                                onChange={() =>
                                  handleCourseToggle(course.groupid)
                                }
                              />
                              <label
                                className="form-check-label w-100"
                                htmlFor={`course-${course.groupid}`}
                              >
                                <strong>{course.class_name}</strong>
                                <div className="small text-muted mt-2">
                                  <div>
                                    <i className="bi bi-sliders me-1"></i>
                                    רמה: {course.level}
                                  </div>
                                  <div>
                                    <i className="bi bi-person-fill me-1"></i>
                                    מורה: {course.teacher_name}
                                  </div>
                                  <div>
                                    <i className="bi bi-people-fill me-1"></i>
                                    מקומות זמינים:{" "}
                                    {course.capacity - course.current_amount}/
                                    {course.capacity}
                                  </div>
                                  <div>
                                    <i className="bi bi-calendar me-1"></i>
                                    גיל מינימלי: {course.min_age}
                                  </div>
                                </div>
                              </label>
                            </div>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>

              {/* Selected Courses Summary */}
              {selectedCourses.length > 0 && (
                <div className="alert alert-info">
                  <strong>קורסים נבחרים: {selectedCourses.length}</strong>
                </div>
              )}

              {/* Submit Button */}
              <div className="d-grid gap-2">
                <button
                  type="submit"
                  className="btn btn-info btn-lg"
                  disabled={
                    loading || selectedCourses.length === 0 || !studentId
                  }
                >
                  {loading ? (
                    <>
                      <span
                        className="spinner-border spinner-border-sm me-2"
                        role="status"
                        aria-hidden="true"
                      ></span>
                      מעבד...
                    </>
                  ) : (
                    <>
                      <i className="bi bi-check-circle me-2"></i>
                      הרשם לקורסים
                    </>
                  )}
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  );
};
