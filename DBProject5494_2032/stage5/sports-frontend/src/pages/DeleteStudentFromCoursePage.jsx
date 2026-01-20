// src/pages/DeleteStudentFromCoursePage.jsx
import { useState } from "react";

export const DeleteStudentFromCoursePage = ({ onGoBack, onShowResult }) => {
  const [studentId, setStudentId] = useState("");
  const [enrolledCourses, setEnrolledCourses] = useState([]);
  const [selectedCourses, setSelectedCourses] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [coursesLoaded, setCoursesLoaded] = useState(false);

  // Fetch student's enrolled courses
  const loadStudentCourses = async (id) => {
    if (!id || id.trim() === "") {
      setError("Please enter a student ID");
      setEnrolledCourses([]);
      setCoursesLoaded(false);
      return;
    }

    try {
      setLoading(true);
      setError("");
      const response = await fetch(
        `http://localhost:3001/api/students/enrolled-courses/${id}`,
      );
      if (!response.ok) {
        throw new Error("Student not found or has no courses");
      }
      const courses = await response.json();

      if (courses.length === 0) {
        setError("Student is not enrolled in any courses");
        setEnrolledCourses([]);
      } else {
        setEnrolledCourses(courses);
      }
      setCoursesLoaded(true);
      setSelectedCourses([]);
    } catch (err) {
      setError("Error loading student courses: " + err.message);
      console.error(err);
      setEnrolledCourses([]);
      setCoursesLoaded(true);
    } finally {
      setLoading(false);
    }
  };

  // Handle course selection
  const handleCourseToggle = (groupId) => {
    setSelectedCourses((prev) =>
      prev.includes(groupId)
        ? prev.filter((id) => id !== groupId)
        : [...prev, groupId],
    );
  };

  // Handle deletion
  const handleDelete = async (e) => {
    e.preventDefault();

    if (!studentId || studentId.trim() === "") {
      setError("Please enter a student ID");
      return;
    }

    if (selectedCourses.length === 0) {
      setError("Please select at least one course to delete from");
      return;
    }

    try {
      setLoading(true);
      setError("");

      const response = await fetch(
        "http://localhost:3001/api/students/delete-enrollment",
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
        throw new Error(data.error || "Deletion failed");
      }

      onShowResult(
        "success",
        "הסרה הושלמה בהצלחה",
        `תלמיד ${studentId} הוסר מ-${selectedCourses.length} קורסים`,
      );

      // Reset form
      setStudentId("");
      setEnrolledCourses([]);
      setSelectedCourses([]);
      setCoursesLoaded(false);
    } catch (err) {
      setError("Error during deletion: " + err.message);
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="screen-container bg-danger-subtle">
      <div className="container py-5">
        <button onClick={onGoBack} className="btn btn-secondary mb-4">
          <i className="bi bi-arrow-right me-2"></i>
          חזרה
        </button>

        <div className="card shadow-lg">
          <div className="card-header bg-danger">
            <h2 className="mb-0">
              <i className="bi bi-person-x-fill me-2"></i>
              הסרת תלמיד מקורסים
            </h2>
          </div>
          <div className="card-body">
            <form onSubmit={handleDelete}>
              {/* Student ID Input */}
              <div className="mb-4">
                <label htmlFor="studentId" className="form-label">
                  <strong>מזהה תלמיד:</strong>
                </label>
                <div className="input-group">
                  <input
                    type="number"
                    id="studentId"
                    className="form-control"
                    value={studentId}
                    onChange={(e) => {
                      setStudentId(e.target.value);
                      setCoursesLoaded(false);
                      setEnrolledCourses([]);
                    }}
                    placeholder="הזן מזהה תלמיד"
                    disabled={loading}
                  />
                  <button
                    type="button"
                    className="btn btn-outline-secondary"
                    onClick={() => loadStudentCourses(studentId)}
                    disabled={loading || !studentId}
                  >
                    {loading ? (
                      <span
                        className="spinner-border spinner-border-sm"
                        role="status"
                        aria-hidden="true"
                      ></span>
                    ) : (
                      <>
                        <i className="bi bi-search me-1"></i>
                        חפש קורסים
                      </>
                    )}
                  </button>
                </div>
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

              {/* Enrolled Courses */}
              {coursesLoaded && enrolledCourses.length > 0 && (
                <div className="mb-4">
                  <h4 className="mb-3">
                    <strong>קורסים המוקדשים לתלמיד:</strong>
                  </h4>

                  <div className="row g-3">
                    {enrolledCourses.map((course) => (
                      <div key={course.group_id} className="col-md-6">
                        <div
                          className={`card h-100 cursor-pointer border-danger ${
                            selectedCourses.includes(course.group_id)
                              ? "border-2 bg-light"
                              : ""
                          }`}
                          onClick={() => handleCourseToggle(course.group_id)}
                          style={{ cursor: "pointer" }}
                        >
                          <div className="card-body">
                            <div className="form-check">
                              <input
                                className="form-check-input"
                                type="checkbox"
                                id={`course-${course.group_id}`}
                                checked={selectedCourses.includes(
                                  course.group_id,
                                )}
                                onChange={() =>
                                  handleCourseToggle(course.group_id)
                                }
                              />
                              <label
                                className="form-check-label w-100"
                                htmlFor={`course-${course.group_id}`}
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
                                    <i className="bi bi-calendar me-1"></i>
                                    יום: {course.day_of_week}
                                  </div>
                                  <div>
                                    <i className="bi bi-clock me-1"></i>
                                    זמן: {course.start_time} - {course.end_time}
                                  </div>
                                </div>
                              </label>
                            </div>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {/* Selected Courses Summary */}
              {selectedCourses.length > 0 && (
                <div className="alert alert-warning">
                  <strong>קורסים שיוסרו: {selectedCourses.length}</strong>
                </div>
              )}

              {/* Submit Button */}
              <div className="d-grid gap-2">
                <button
                  type="submit"
                  className="btn btn-danger btn-lg"
                  disabled={
                    loading ||
                    selectedCourses.length === 0 ||
                    !studentId ||
                    !coursesLoaded
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
                      <i className="bi bi-trash me-2"></i>
                      הסר מקורסים
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
