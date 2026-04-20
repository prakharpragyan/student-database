"""
run_queries.py
--------------
Creates the student database in-memory, seeds data, and runs
all example queries — printing results to the terminal.

Usage:
    python run_queries.py
"""

import sqlite3
import os

DB_FILE = "db/student_database.db"

# ── Helpers ──────────────────────────────────────────────────────────────────

def read_sql_file(filename):
    with open(filename, "r") as f:
        return f.read()


def run_script(cursor, sql):
    cursor.executescript(sql)


def run_query(cursor, sql, title=""):
    print("\n" + "=" * 65)
    print(f"  {title}")
    print("=" * 65)
    cursor.execute(sql)
    cols = [desc[0] for desc in cursor.description]
    rows = cursor.fetchall()

    # Column widths
    widths = [max(len(str(col)), max((len(str(r[i])) for r in rows), default=0))
              for i, col in enumerate(cols)]

    header = " | ".join(str(col).ljust(widths[i]) for i, col in enumerate(cols))
    sep    = "-+-".join("-" * w for w in widths)
    print(header)
    print(sep)
    for row in rows:
        print(" | ".join(str(v).ljust(widths[i]) for i, v in enumerate(row)))
    print(f"\n  ↳ {len(rows)} row(s) returned")


# ── Main ─────────────────────────────────────────────────────────────────────

def main():
    # Remove existing DB so we always start fresh
    if os.path.exists(DB_FILE):
        os.remove(DB_FILE)

    conn   = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()

    print("\n📦  Creating schema...")
    run_script(cursor, read_sql_file("sql/schema.sql"))

    print("🌱  Seeding data...")
    run_script(cursor, read_sql_file("sql/seed_data.sql"))
    conn.commit()
    print("✅  Database ready!\n")

    # ── SELECT queries ────────────────────────────────────────────────
    run_query(cursor,
        "SELECT first_name, last_name, email FROM students;",
        "Q2 · All Students (name + email)")

    run_query(cursor,
        "SELECT course_name, course_code, credits FROM courses;",
        "Q3 · All Courses")

    # ── WHERE queries ─────────────────────────────────────────────────
    run_query(cursor,
        """SELECT first_name, last_name, email
           FROM students WHERE dept_id = 1;""",
        "Q5 · Students in Computer Science")

    run_query(cursor,
        """SELECT first_name, last_name, enrollment_year
           FROM students WHERE enrollment_year = 2022;""",
        "Q6 · Students enrolled in 2022")

    run_query(cursor,
        """SELECT first_name, last_name, age
           FROM students WHERE age BETWEEN 20 AND 22;""",
        "Q7 · Students aged 20–22")

    run_query(cursor,
        """SELECT s.first_name, s.last_name, g.marks, g.grade
           FROM students s
           JOIN enrollments e ON s.student_id = e.student_id
           JOIN grades g      ON e.enrollment_id = g.enrollment_id
           WHERE g.marks > 85;""",
        "Q10 · Students scoring above 85")

    run_query(cursor,
        """SELECT s.first_name, s.last_name, c.course_name, g.marks, g.grade
           FROM students s
           JOIN enrollments e ON s.student_id = e.student_id
           JOIN grades g      ON e.enrollment_id = g.enrollment_id
           JOIN courses c     ON e.course_id = c.course_id
           WHERE g.marks < 60;""",
        "Q12 · At-Risk Students (marks < 60)")

    # ── ORDER BY queries ──────────────────────────────────────────────
    run_query(cursor,
        """SELECT first_name, last_name, age
           FROM students ORDER BY last_name ASC;""",
        "Q13 · Students ordered by last name (A→Z)")

    run_query(cursor,
        """SELECT s.first_name, s.last_name, c.course_name, g.marks, g.grade
           FROM students s
           JOIN enrollments e ON s.student_id = e.student_id
           JOIN grades g      ON e.enrollment_id = g.enrollment_id
           JOIN courses c     ON e.course_id = c.course_id
           ORDER BY g.marks DESC LIMIT 5;""",
        "Q17 · Top 5 Students by Marks")

    # ── GROUP BY queries ──────────────────────────────────────────────
    run_query(cursor,
        """SELECT d.dept_name, COUNT(s.student_id) AS total_students
           FROM departments d
           LEFT JOIN students s ON d.dept_id = s.dept_id
           GROUP BY d.dept_id, d.dept_name
           ORDER BY total_students DESC;""",
        "Q18 · Students per Department")

    run_query(cursor,
        """SELECT c.course_name, c.course_code,
                  ROUND(AVG(g.marks), 2) AS avg_marks,
                  COUNT(g.grade_id)      AS total_students_appeared
           FROM courses c
           JOIN enrollments e ON c.course_id = e.course_id
           JOIN grades g      ON e.enrollment_id = g.enrollment_id
           GROUP BY c.course_id, c.course_name, c.course_code
           ORDER BY avg_marks DESC;""",
        "Q19 · Average Marks per Course")

    run_query(cursor,
        """SELECT gender, COUNT(*) AS count
           FROM students GROUP BY gender;""",
        "Q20 · Students by Gender")

    run_query(cursor,
        """SELECT grade, COUNT(*) AS student_count
           FROM grades GROUP BY grade ORDER BY grade;""",
        "Q23 · Grade Distribution")

    run_query(cursor,
        """SELECT d.dept_name,
                  ROUND(AVG(g.marks), 2) AS avg_marks,
                  MAX(g.marks)           AS highest_marks,
                  MIN(g.marks)           AS lowest_marks
           FROM departments d
           JOIN students s    ON d.dept_id = s.dept_id
           JOIN enrollments e ON s.student_id = e.student_id
           JOIN grades g      ON e.enrollment_id = g.enrollment_id
           GROUP BY d.dept_id, d.dept_name
           ORDER BY avg_marks DESC;""",
        "Q24 · Dept-wise Performance Summary")

    # ── HAVING queries ────────────────────────────────────────────────
    run_query(cursor,
        """SELECT c.course_name, ROUND(AVG(g.marks), 2) AS avg_marks
           FROM courses c
           JOIN enrollments e ON c.course_id = e.course_id
           JOIN grades g      ON e.enrollment_id = g.enrollment_id
           GROUP BY c.course_id, c.course_name
           HAVING AVG(g.marks) > 80
           ORDER BY avg_marks DESC;""",
        "Q26 · Courses with Avg Marks > 80 (HAVING)")

    run_query(cursor,
        """SELECT s.first_name, s.last_name, COUNT(e.enrollment_id) AS courses_enrolled
           FROM students s
           JOIN enrollments e ON s.student_id = e.student_id
           GROUP BY s.student_id, s.first_name, s.last_name
           HAVING COUNT(e.enrollment_id) > 2;""",
        "Q27 · Students enrolled in more than 2 courses")

    # ── Full Report ───────────────────────────────────────────────────
    run_query(cursor,
        """SELECT s.first_name || ' ' || s.last_name AS student_name,
                  d.dept_name,
                  ROUND(AVG(g.marks), 2)             AS avg_marks
           FROM students s
           JOIN departments d ON s.dept_id = d.dept_id
           JOIN enrollments e ON s.student_id = e.student_id
           JOIN grades g      ON e.enrollment_id = g.enrollment_id
           GROUP BY s.student_id, student_name, d.dept_name
           ORDER BY avg_marks DESC;""",
        "Q29 · Student Average Marks Report (Best to Worst)")

    conn.close()
    print("\n" + "=" * 65)
    print("  ✅  All queries executed successfully!")
    print(f"  📁  Database saved to: {DB_FILE}")
    print("=" * 65 + "\n")


if __name__ == "__main__":
    main()