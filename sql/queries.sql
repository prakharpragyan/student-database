-- ============================================
-- STUDENT DATABASE - SQL Queries
-- Covers: SELECT, WHERE, GROUP BY, ORDER BY
-- ============================================


-- ─────────────────────────────────────────
-- SECTION 1: Basic SELECT Queries
-- ─────────────────────────────────────────

-- Q1: List all students
SELECT * FROM students;

-- Q2: Select specific columns — student names and emails
SELECT first_name, last_name, email
FROM students;

-- Q3: List all courses with their credits
SELECT course_name, course_code, credits
FROM courses;

-- Q4: Show all departments and their heads
SELECT dept_name, hod
FROM departments;


-- ─────────────────────────────────────────
-- SECTION 2: WHERE Clause Queries
-- ─────────────────────────────────────────

-- Q5: Find all students from Computer Science department (dept_id = 1)
SELECT first_name, last_name, email
FROM students
WHERE dept_id = 1;

-- Q6: Find students who enrolled in year 2022
SELECT first_name, last_name, enrollment_year
FROM students
WHERE enrollment_year = 2022;

-- Q7: Find students aged between 20 and 22
SELECT first_name, last_name, age
FROM students
WHERE age BETWEEN 20 AND 22;

-- Q8: Find all female students
SELECT first_name, last_name, dept_id
FROM students
WHERE gender = 'Female';

-- Q9: Find courses with 4 credits
SELECT course_name, course_code, credits
FROM courses
WHERE credits = 4;

-- Q10: Find students who scored above 85 marks
SELECT s.first_name, s.last_name, g.marks, g.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN grades g      ON e.enrollment_id = g.enrollment_id
WHERE g.marks > 85;

-- Q11: Find students who got grade 'A+' or 'A'
SELECT s.first_name, s.last_name, c.course_name, g.marks, g.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN grades g      ON e.enrollment_id = g.enrollment_id
JOIN courses c     ON e.course_id = c.course_id
WHERE g.grade IN ('A+', 'A')
ORDER BY g.marks DESC;

-- Q12: Find students who scored below 60 (at risk)
SELECT s.first_name, s.last_name, c.course_name, g.marks, g.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN grades g      ON e.enrollment_id = g.enrollment_id
JOIN courses c     ON e.course_id = c.course_id
WHERE g.marks < 60;


-- ─────────────────────────────────────────
-- SECTION 3: ORDER BY Queries
-- ─────────────────────────────────────────

-- Q13: List all students ordered by last name alphabetically
SELECT first_name, last_name, age
FROM students
ORDER BY last_name ASC;

-- Q14: List students ordered by age (youngest first)
SELECT first_name, last_name, age
FROM students
ORDER BY age ASC;

-- Q15: List all grades sorted by marks (highest first)
SELECT s.first_name, s.last_name, c.course_name, g.marks, g.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN grades g      ON e.enrollment_id = g.enrollment_id
JOIN courses c     ON e.course_id = c.course_id
ORDER BY g.marks DESC;

-- Q16: List courses ordered by credits descending
SELECT course_name, course_code, credits
FROM courses
ORDER BY credits DESC;

-- Q17: Top 5 students by marks
SELECT s.first_name, s.last_name, g.marks, g.grade, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN grades g      ON e.enrollment_id = g.enrollment_id
JOIN courses c     ON e.course_id = c.course_id
ORDER BY g.marks DESC
LIMIT 5;


-- ─────────────────────────────────────────
-- SECTION 4: GROUP BY Queries
-- ─────────────────────────────────────────

-- Q18: Count number of students in each department
SELECT d.dept_name, COUNT(s.student_id) AS total_students
FROM departments d
LEFT JOIN students s ON d.dept_id = s.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY total_students DESC;

-- Q19: Average marks per course
SELECT c.course_name, c.course_code,
       ROUND(AVG(g.marks), 2) AS avg_marks,
       COUNT(g.grade_id)      AS total_students_appeared
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
JOIN grades g      ON e.enrollment_id = g.enrollment_id
GROUP BY c.course_id, c.course_name, c.course_code
ORDER BY avg_marks DESC;

-- Q20: Count students by gender
SELECT gender, COUNT(*) AS count
FROM students
GROUP BY gender;

-- Q21: Count students enrolled per year
SELECT enrollment_year, COUNT(*) AS students_enrolled
FROM students
GROUP BY enrollment_year
ORDER BY enrollment_year ASC;

-- Q22: Total credits per department (sum of all courses offered)
SELECT d.dept_name, SUM(c.credits) AS total_credits_offered
FROM departments d
JOIN courses c ON d.dept_id = c.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY total_credits_offered DESC;

-- Q23: Grade distribution — how many students got each grade
SELECT grade, COUNT(*) AS student_count
FROM grades
GROUP BY grade
ORDER BY grade ASC;

-- Q24: Average marks per department
SELECT d.dept_name,
       ROUND(AVG(g.marks), 2) AS avg_marks,
       MAX(g.marks)           AS highest_marks,
       MIN(g.marks)           AS lowest_marks
FROM departments d
JOIN students s    ON d.dept_id = s.dept_id
JOIN enrollments e ON s.student_id = e.student_id
JOIN grades g      ON e.enrollment_id = g.enrollment_id
GROUP BY d.dept_id, d.dept_name
ORDER BY avg_marks DESC;


-- ─────────────────────────────────────────
-- SECTION 5: GROUP BY with HAVING
-- ─────────────────────────────────────────

-- Q25: Departments with more than 2 students
SELECT d.dept_name, COUNT(s.student_id) AS total_students
FROM departments d
JOIN students s ON d.dept_id = s.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING COUNT(s.student_id) > 2;

-- Q26: Courses where average marks are above 80
SELECT c.course_name, ROUND(AVG(g.marks), 2) AS avg_marks
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
JOIN grades g      ON e.enrollment_id = g.enrollment_id
GROUP BY c.course_id, c.course_name
HAVING AVG(g.marks) > 80
ORDER BY avg_marks DESC;

-- Q27: Students enrolled in more than 2 courses
SELECT s.first_name, s.last_name, COUNT(e.enrollment_id) AS courses_enrolled
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.enrollment_id) > 2;


-- ─────────────────────────────────────────
-- SECTION 6: Combined / Advanced Queries
-- ─────────────────────────────────────────

-- Q28: Full student report — name, department, course, marks, grade
SELECT s.first_name || ' ' || s.last_name AS student_name,
       d.dept_name,
       c.course_name,
       c.credits,
       g.marks,
       g.grade
FROM students s
JOIN departments d ON s.dept_id = d.dept_id
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c     ON e.course_id = c.course_id
JOIN grades g      ON e.enrollment_id = g.enrollment_id
ORDER BY s.last_name, g.marks DESC;

-- Q29: Students with their average marks across all courses
SELECT s.first_name || ' ' || s.last_name AS student_name,
       d.dept_name,
       ROUND(AVG(g.marks), 2)             AS avg_marks
FROM students s
JOIN departments d ON s.dept_id = d.dept_id
JOIN enrollments e ON s.student_id = e.student_id
JOIN grades g      ON e.enrollment_id = g.enrollment_id
GROUP BY s.student_id, student_name, d.dept_name
ORDER BY avg_marks DESC;

-- Q30: Students who scored below department average (needs subquery)
SELECT s.first_name, s.last_name, d.dept_name, g.marks,
       ROUND(dept_avg.avg_marks, 2) AS dept_average
FROM students s
JOIN departments d  ON s.dept_id = d.dept_id
JOIN enrollments e  ON s.student_id = e.student_id
JOIN grades g       ON e.enrollment_id = g.enrollment_id
JOIN (
    SELECT s2.dept_id, AVG(g2.marks) AS avg_marks
    FROM students s2
    JOIN enrollments e2 ON s2.student_id = e2.student_id
    JOIN grades g2      ON e2.enrollment_id = g2.enrollment_id
    GROUP BY s2.dept_id
) dept_avg ON s.dept_id = dept_avg.dept_id
WHERE g.marks < dept_avg.avg_marks
ORDER BY d.dept_name, g.marks ASC;