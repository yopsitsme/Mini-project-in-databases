// src/utils/apiService.js
const API_URL = "http://localhost:3001/api";

const apiService = {
  // Teacher APIs
  async getTeacherWorkload(teacherId) {
    const response = await fetch(`${API_URL}/teachers/workload/${teacherId}`);
    return response.json();
  },

  async getTeacherSchedule(teacherId) {
    const response = await fetch(`${API_URL}/teachers/schedule/${teacherId}`);
    return response.json();
  },

  async getAllTeachers() {
    const response = await fetch(`${API_URL}/teachers`);
    return response.json();
  },

  async createTeacher(teacherData) {
    const response = await fetch(`${API_URL}/teachers`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(teacherData),
    });
    return response.json();
  },

  // Student APIs
  async getStudentSchedule(studentId) {
    const response = await fetch(`${API_URL}/students/schedule/${studentId}`);
    return response.json();
  },

  async getAllStudents() {
    const response = await fetch(`${API_URL}/students`);
    return response.json();
  },

  async createStudent(studentData) {
    const response = await fetch(`${API_URL}/students`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(studentData),
    });
    return response.json();
  },

  async enrollStudent(studentId, groupIds) {
    const response = await fetch(`${API_URL}/students/enroll`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ studentId, groupIds }),
    });
    return response.json();
  },

  // Group APIs
  async getAllGroups() {
    const response = await fetch(`${API_URL}/groups`);
    return response.json();
  },

  async createGroup(groupData) {
    const response = await fetch(`${API_URL}/groups`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(groupData),
    });
    return response.json();
  },

  // Revenue API
  async getMonthlyRevenue(year, month) {
    const response = await fetch(`${API_URL}/monthly-revenue/${year}/${month}`);
    return response.json();
  },

  // Sports Class APIs
  async getAllSportsClasses() {
    const response = await fetch(`${API_URL}/sports-classes`);
    return response.json();
  },

  async createSportsClass(classData) {
    const response = await fetch(`${API_URL}/sports-classes`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(classData),
    });
    return response.json();
  },

  // Parent APIs
  async getAllParents() {
    const response = await fetch(`${API_URL}/parents`);
    return response.json();
  },

  async createParent(parentData) {
    const response = await fetch(`${API_URL}/parents`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(parentData),
    });
    return response.json();
  },

  // Year Group APIs
  async getAllYearGroups() {
    const response = await fetch(`${API_URL}/year-groups`);
    return response.json();
  },
};

export default apiService;
