USE school;

-- 1. Create the enrollments table
CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE
);

-- 2. Add foreign keys
-- Run these only once if the foreign keys do not exist yet.
-- ALTER TABLE enrollments
-- ADD CONSTRAINT fk_student
-- FOREIGN KEY (student_id) REFERENCES students(id);

-- ALTER TABLE enrollments
-- ADD CONSTRAINT fk_course
-- FOREIGN KEY (course_id) REFERENCES courses(course_id);

-- 3. View existing students and courses
SELECT * FROM students;
SELECT * FROM courses;

-- 4. Insert enrollment records
-- These IDs match the original Activity 1 inserts
-- if the records and course IDs have not changed.
INSERT INTO enrollments
    (student_id, course_id, enrollment_date)
VALUES
    (1, 1, '2026-10-12'),
    (1, 2, '2026-10-12'),
    (2, 1, '2026-10-12'),
    (4, 3, '2026-10-12');

-- 5. Display all enrollments
SELECT * FROM enrollments;

-- 6. JOIN: Display student names and course names
SELECT
    students.name,
    courses.course_name,
    enrollments.enrollment_date
FROM enrollments
JOIN students
    ON enrollments.student_id = students.id
JOIN courses
    ON enrollments.course_id = courses.course_id;

-- 7. WHERE: Filter enrollments by BSIT
SELECT
    students.name,
    courses.course_name
FROM enrollments
JOIN students
    ON enrollments.student_id = students.id
JOIN courses
    ON enrollments.course_id = courses.course_id
WHERE courses.course_name = 'BSIT';

-- 8. ORDER BY: Sort student names alphabetically
SELECT
    students.name,
    courses.course_name
FROM enrollments
JOIN students
    ON enrollments.student_id = students.id
JOIN courses
    ON enrollments.course_id = courses.course_id
ORDER BY students.name ASC;

-- 9. ORDER BY: Show names in descending order
SELECT
    students.name,
    courses.course_name
FROM enrollments
JOIN students
    ON enrollments.student_id = students.id
JOIN courses
    ON enrollments.course_id = courses.course_id
ORDER BY students.name DESC;

-- 10. Count students
SELECT COUNT(*) AS total_students
FROM students;

-- 11. Count enrollments
SELECT COUNT(*) AS total_enrollments
FROM enrollments;

-- 12. Count enrollments per course
SELECT
    courses.course_name,
    COUNT(enrollments.enrollment_id) AS total_enrollments
FROM courses
LEFT JOIN enrollments
    ON courses.course_id = enrollments.course_id
GROUP BY courses.course_id, courses.course_name;

-- 13. Find the most popular course
SELECT
    courses.course_name,
    COUNT(enrollments.enrollment_id) AS total_enrollments
FROM courses
LEFT JOIN enrollments
    ON courses.course_id = enrollments.course_id
GROUP BY courses.course_id, courses.course_name
ORDER BY total_enrollments DESC
LIMIT 1;

-- 14. Student enrollment report
SELECT
    students.id,
    students.name,
    students.course AS student_program,
    courses.course_name AS enrolled_course,
    enrollments.enrollment_date
FROM students
JOIN enrollments
    ON students.id = enrollments.student_id
JOIN courses
    ON enrollments.course_id = courses.course_id
ORDER BY students.name ASC;
