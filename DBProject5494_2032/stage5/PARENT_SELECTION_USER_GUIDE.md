# Student Registration with Parent Selection - User Guide

## Overview

When registering a new student, you now have two options for handling the parent information:

1. **Select an Existing Parent** - Choose a parent already in the system
2. **Create a New Parent** - Add a new parent while registering the student

## Step-by-Step Guide

### Option 1: Registering a Student with an Existing Parent

#### Steps:

1. Click on "רישום תלמיד חדש" (Register New Student) from the main menu
2. Fill in the student's details:
   - **שם פרטי** (First Name) \*required
   - **שם משפחה** (Last Name) \*required
   - דוא״ל (Email) - optional
   - טלפון (Phone) - optional
   - **תאריך לידה** (Birth Date) \*required
   - כתובת (Address) - optional

3. In the **הורה** (Parent) section:
   - Make sure **"בחר הורה קיים"** (Select Existing Parent) is selected (it's the default)
4. Click the **dropdown** and select a parent from the list
   - Parents are displayed as: "FirstName LastName (Phone)"
5. Click **"שמור תלמיד"** (Save Student)

6. You'll see a success message with the new student ID

---

### Option 2: Creating a New Parent While Registering a Student

#### Steps:

1. Start filling in the student information (as in Option 1)

2. In the **הורה** (Parent) section:
   - Click on **"צור הורה חדש"** (Create New Parent)
   - A new form will appear below with parent fields

3. Fill in the parent details:
   - **שם פרטי** (First Name) \*required
   - **שם משפחה** (Last Name) \*required
   - דוא״ל (Email) - optional
   - טלפון (Phone) - optional
   - **תאריך לידה** (Birth Date) \*required

4. Click **"שמור תלמיד"** (Save Student)

5. The system will:
   - Create the parent first
   - Create the student with the new parent ID
   - Show a success message

---

## Important Notes

### Required Fields

- Student: First Name, Last Name, Birth Date
- New Parent (if creating): First Name, Last Name, Birth Date

### Optional Fields

- Email, Phone, Address

### Error Messages

| Error                                      | Cause                          | Solution                                             |
| ------------------------------------------ | ------------------------------ | ---------------------------------------------------- |
| "חובה למלא: שם פרטי, שם משפחה ותאריך לידה" | Missing required parent fields | Fill in all required parent fields before submitting |
| "שגיאה בעת יצירת הורה"                     | Parent creation failed         | Check your internet connection and try again         |
| "שגיאה ברישום"                             | Student creation failed        | Check your internet connection and try again         |
| "לא היה ניתן לטעון את רשימת ההורים"        | Cannot load parents list       | The server may be offline - try refreshing the page  |

---

## Features

✅ **Fast Registration** - Create both parent and student in one form
✅ **Prevents Duplicates** - Reuse existing parents when possible
✅ **Data Validation** - Required fields are enforced
✅ **Loading Indicators** - Visual feedback during processing
✅ **Error Handling** - Clear error messages in Hebrew
✅ **Mobile Friendly** - Works on desktop and tablet

---

## Tips & Best Practices

1. **Check existing parents first** - Before creating a new parent, check if they already exist in the system
2. **Complete information** - Fill in all available fields for better record keeping
3. **Verify data** - Double-check names and dates before submitting
4. **Handle errors** - If you get an error, check your connection and try again

---

## Technical Details

### Parent List

- Only shows parents who have students already assigned
- Parents are sorted alphabetically by first name then last name
- Phone numbers are displayed to help identify the correct parent

### Data Storage

- New parents are added to the system's person table
- Student-parent relationship is established in the student table
- All data is validated and committed in a single transaction

### UI Elements

- **"בחר הורה קיים"** (Select Existing Parent) - Radio button to switch to dropdown mode
- **"צור הורה חדש"** (Create New Parent) - Radio button to switch to create new parent mode
- **Form Highlight** - New parent form is highlighted in light gray for easy identification
