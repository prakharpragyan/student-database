-- ============================================
-- STUDENT DATABASE - Schema Design
-- ============================================

-- Drop tables if they already exist (for re-runs)
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS grades;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS departments;

-- 1. Departments Table
CREATE TABLE departments (
    dept_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    dept_name   TEXT    NOT NULL UNIQUE,
    hod         TEXT    NOT NULL   -- Head of Department
);

-- 2. Students Table
CREATE TABLE students (
    student_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name   TEXT    NOT NULL,
    last_name    TEXT    NOT NULL,
    email        TEXT    NOT NULL UNIQUE,
    age          INTEGER NOT NULL CHECK(age >= 16 AND age <= 60),
    gender       TEXT    CHECK(gender IN ('Male', 'Female', 'Other')),
    dept_id      INTEGER NOT NULL,
    enrollment_year INTEGER NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 3. Courses Table
CREATE TABLE courses (
    course_id    INTEGER PRIMARY KEY AUTOINCREMENT,
    course_name  TEXT    NOT NULL,
    course_code  TEXT    NOT NULL UNIQUE,
    credits      INTEGER NOT NULL CHECK(credits BETWEEN 1 AND 6),
    dept_id      INTEGER NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 4. Enrollments Table (which student is enrolled in which course)
CREATE TABLE enrollments (
    enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id    INTEGER NOT NULL,
    course_id     INTEGER NOT NULL,
    semester      TEXT    NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id)  REFERENCES courses(course_id),
    UNIQUE(student_id, course_id, semester)
);

-- 5. Grades Table
CREATE TABLE grades (
    grade_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    enrollment_id INTEGER NOT NULL UNIQUE,
    marks         REAL    NOT NULL CHECK(marks >= 0 AND marks <= 100),
    grade         TEXT    NOT NULL,
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);