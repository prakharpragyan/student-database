-- ============================================
-- STUDENT DATABASE - Sample Data (Seed)
-- ============================================

-- Departments
INSERT INTO departments (dept_name, hod) VALUES
    ('Computer Science',  'Dr. Anita Sharma'),
    ('Mathematics',       'Dr. Rajiv Mehta'),
    ('Physics',           'Dr. Sunita Roy'),
    ('Electronics',       'Dr. Arun Kumar'),
    ('Civil Engineering', 'Dr. Priya Das');

-- Students
INSERT INTO students (first_name, last_name, email, age, gender, dept_id, enrollment_year) VALUES
    ('Aarav',    'Singh',      'aarav.singh@college.edu',      20, 'Male',   1, 2022),
    ('Priya',    'Sharma',     'priya.sharma@college.edu',     21, 'Female', 1, 2021),
    ('Rohan',    'Verma',      'rohan.verma@college.edu',      22, 'Male',   2, 2021),
    ('Sneha',    'Das',        'sneha.das@college.edu',        20, 'Female', 3, 2022),
    ('Karan',    'Patel',      'karan.patel@college.edu',      23, 'Male',   4, 2020),
    ('Megha',    'Rao',        'megha.rao@college.edu',        21, 'Female', 1, 2022),
    ('Arjun',    'Nair',       'arjun.nair@college.edu',       22, 'Male',   2, 2021),
    ('Tanya',    'Gupta',      'tanya.gupta@college.edu',      19, 'Female', 5, 2023),
    ('Vikram',   'Joshi',      'vikram.joshi@college.edu',     24, 'Male',   3, 2020),
    ('Neha',     'Mishra',     'neha.mishra@college.edu',      20, 'Female', 4, 2022),
    ('Aditya',   'Bose',       'aditya.bose@college.edu',      21, 'Male',   1, 2021),
    ('Kavya',    'Iyer',       'kavya.iyer@college.edu',       22, 'Female', 5, 2021),
    ('Siddharth','Malhotra',   'siddharth.m@college.edu',      23, 'Male',   2, 2020),
    ('Ananya',   'Reddy',      'ananya.reddy@college.edu',     20, 'Female', 1, 2022),
    ('Harsh',    'Trivedi',    'harsh.trivedi@college.edu',    21, 'Male',   4, 2022);

-- Courses
INSERT INTO courses (course_name, course_code, credits, dept_id) VALUES
    ('Data Structures',         'CS101', 4, 1),
    ('Database Management',     'CS102', 4, 1),
    ('Operating Systems',       'CS103', 3, 1),
    ('Calculus',                'MA101', 4, 2),
    ('Linear Algebra',          'MA102', 3, 2),
    ('Mechanics',               'PH101', 4, 3),
    ('Electromagnetism',        'PH102', 3, 3),
    ('Digital Circuits',        'EC101', 4, 4),
    ('Signals & Systems',       'EC102', 3, 4),
    ('Structural Analysis',     'CV101', 4, 5),
    ('Fluid Mechanics',         'CV102', 3, 5),
    ('Python Programming',      'CS104', 3, 1);

-- Enrollments
INSERT INTO enrollments (student_id, course_id, semester) VALUES
    (1,  1,  'Sem-3'), (1,  2,  'Sem-3'), (1,  12, 'Sem-3'),
    (2,  1,  'Sem-5'), (2,  2,  'Sem-5'), (2,  3,  'Sem-5'),
    (3,  4,  'Sem-5'), (3,  5,  'Sem-5'),
    (4,  6,  'Sem-3'), (4,  7,  'Sem-3'),
    (5,  8,  'Sem-7'), (5,  9,  'Sem-7'),
    (6,  1,  'Sem-3'), (6,  2,  'Sem-3'), (6,  12, 'Sem-3'),
    (7,  4,  'Sem-5'), (7,  5,  'Sem-5'),
    (8,  10, 'Sem-1'), (8,  11, 'Sem-1'),
    (9,  6,  'Sem-7'), (9,  7,  'Sem-7'),
    (10, 8,  'Sem-3'), (10, 9,  'Sem-3'),
    (11, 1,  'Sem-5'), (11, 2,  'Sem-5'), (11, 3,  'Sem-5'),
    (12, 10, 'Sem-5'), (12, 11, 'Sem-5'),
    (13, 4,  'Sem-7'), (13, 5,  'Sem-7'),
    (14, 1,  'Sem-3'), (14, 12, 'Sem-3'),
    (15, 8,  'Sem-3'), (15, 9,  'Sem-3');

-- Grades (marks and letter grades)
INSERT INTO grades (enrollment_id, marks, grade) VALUES
    (1,  88,  'A'), (2,  76,  'B'), (3,  91,  'A+'),
    (4,  72,  'B'), (5,  85,  'A'), (6,  63,  'C'),
    (7,  78,  'B'), (8,  55,  'D'),
    (9,  90,  'A+'), (10, 82,  'A'),
    (11, 67,  'C'), (12, 74,  'B'),
    (13, 95,  'A+'), (14, 88,  'A'), (15, 79,  'B'),
    (16, 61,  'C'), (17, 70,  'B'),
    (18, 84,  'A'), (19, 77,  'B'),
    (20, 92,  'A+'), (21, 68,  'C'),
    (22, 58,  'D'), (23, 75,  'B'),
    (24, 83,  'A'), (25, 90,  'A+'), (26, 71,  'B'),
    (27, 88,  'A'), (28, 65,  'C'),
    (29, 79,  'B'), (30, 86,  'A'),
    (31, 93,  'A+'), (32, 80,  'A'),
    (33, 62,  'C'), (34, 74,  'B');