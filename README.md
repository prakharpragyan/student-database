# 🎓 Student Database – SQL Basics Project

A complete SQL project demonstrating database design and core SQL query concepts using a real-world **Student Management System**.

---

## 📌 Project Overview

This project designs a relational student database and demonstrates the use of:
- **SELECT** — retrieve data from tables
- **WHERE** — filter rows based on conditions
- **GROUP BY** — aggregate data by category
- **ORDER BY** — sort query results
- **HAVING** — filter on aggregated results
- **JOINs** — combine data across multiple tables

---

## 🗂️ Database Schema

```
departments  ──< students ──< enrollments >── courses
                                   │
                                 grades
```

| Table         | Description                                    |
|---------------|------------------------------------------------|
| `departments` | Academic departments (CS, Math, Physics, etc.) |
| `students`    | Student personal & enrollment info             |
| `courses`     | Course catalog with credits                    |
| `enrollments` | Student ↔ Course relationships (many-to-many)  |
| `grades`      | Marks and letter grades per enrollment         |

---

## 📁 File Structure

```
student_database/
│
├── schema.sql       ← Table definitions (CREATE TABLE)
├── seed_data.sql    ← Sample data (INSERT statements)
├── queries.sql      ← All 30 SQL queries with comments
├── run_queries.py   ← Python script to run & display all results
└── README.md        ← This file
```

---

## 🚀 How to Run

### Option 1 — Python Script (Recommended)
```bash
# Make sure Python 3 is installed
python run_queries.py
```
This will:
1. Create `student_database.db` (SQLite)
2. Load schema and seed data
3. Execute all queries and print results to terminal

### Option 2 — SQLite CLI
```bash
sqlite3 student_database.db < schema.sql
sqlite3 student_database.db < seed_data.sql
sqlite3 student_database.db < queries.sql
```

### Option 3 — DB Browser for SQLite (GUI)
1. Download [DB Browser for SQLite](https://sqlitebrowser.org/)
2. Open the app → **New Database** → save as `student_database.db`
3. Go to **Execute SQL** tab
4. Paste and run `schema.sql`, then `seed_data.sql`, then `queries.sql`

---

## 📊 Query Categories

### 1. Basic SELECT
| # | Description |
|---|-------------|
| Q1 | List all students |
| Q2 | Student names and emails |
| Q3 | All courses with credits |
| Q4 | Departments and their heads |

### 2. WHERE Clause
| # | Description |
|---|-------------|
| Q5 | Students in Computer Science |
| Q6 | Students enrolled in 2022 |
| Q7 | Students aged 20–22 |
| Q8 | All female students |
| Q9 | Courses with 4 credits |
| Q10 | Students scoring > 85 marks |
| Q11 | Students with grade A or A+ |
| Q12 | At-risk students (marks < 60) |

### 3. ORDER BY
| # | Description |
|---|-------------|
| Q13 | Students sorted by last name |
| Q14 | Students sorted by age |
| Q15 | All grades sorted highest first |
| Q16 | Courses sorted by credits |
| Q17 | Top 5 students by marks |

### 4. GROUP BY
| # | Description |
|---|-------------|
| Q18 | Count students per department |
| Q19 | Average marks per course |
| Q20 | Students by gender |
| Q21 | Students enrolled per year |
| Q22 | Total credits per department |
| Q23 | Grade distribution (A+, A, B…) |
| Q24 | Dept-wise marks summary |

### 5. GROUP BY + HAVING
| # | Description |
|---|-------------|
| Q25 | Departments with > 2 students |
| Q26 | Courses with avg marks > 80 |
| Q27 | Students in more than 2 courses |

### 6. Advanced / Combined
| # | Description |
|---|-------------|
| Q28 | Full student report with dept + course + grade |
| Q29 | Student average marks across all courses |
| Q30 | Students below their department average |

---

## 🛠️ Technologies Used

- **SQLite** — lightweight relational database
- **SQL** — DDL (schema) + DML (data) + DQL (queries)
- **Python 3** (sqlite3 module) — for running queries programmatically

---

## 👨‍💻 Author

*Submitted as part of SQL Basics course project.*
