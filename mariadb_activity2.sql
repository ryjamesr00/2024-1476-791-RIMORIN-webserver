CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100),
    description VARCHAR(255),
    units INT
);

SELECT * FROM courses;

INSERT INTO courses (course_name, description, units)
VALUES
('BSIT', 'Website development', 3),
('BSDA', 'Database management', 3),
('BSIT', 'Programming fundamentals', 3),
('BSCS', 'Computer networking', 3),
('BSIT', 'System analysis and design', 3);

CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE
);

ALTER TABLE enrollments
ADD CONSTRAINT fk_student
FOREIGN KEY (student_id)
REFERENCES students(id);

ALTER TABLE enrollments
ADD CONSTRAINT fk_course
FOREIGN KEY (course_id)
REFERENCES courses(course_id);

DESCRIBE enrollments;

SELECT * FROM students;
SELECT * FROM courses;

INSERT INTO enrollments
(student_id, course_id, enrollment_date)
VALUES
(1, 1, '2026-10-13'),
(1, 2, '2026-10-13'),
(2, 1, '2026-10-13'),
(2, 3, '2026-10-13'),
(3, 2, '2026-10-13'),
(3, 3, '2026-10-13'),
(1, 3, '2026-10-13'),
(2, 4, '2026-10-13'),
(3, 4, '2026-10-13'),
(1, 5, '2026-10-13');

SELECT * FROM enrollments;

SELECT
    students.name,
    courses.course_name,
    enrollments.enrollment_date
FROM enrollments
JOIN students
    ON enrollments.student_id = students.id
JOIN courses
    ON enrollments.course_id = courses.course_id;

SELECT students.name, courses.course_name
FROM enrollments
JOIN students
    ON enrollments.student_id = students.id
JOIN courses
    ON enrollments.course_id = courses.course_id
WHERE courses.course_name = 'Web Development';

SELECT
    students.name,
    courses.course_name
FROM enrollments
JOIN students
    ON enrollments.student_id = students.id
JOIN courses
    ON enrollments.course_id = courses.course_id
ORDER BY students.name ASC;

SELECT COUNT(*) AS total_students
FROM students;

SELECT COUNT(*) AS total_enrollments
FROM enrollments;

SELECT
    courses.course_name,
    COUNT(enrollments.student_id) AS number_of_students
FROM courses
LEFT JOIN enrollments
    ON courses.course_id = enrollments.course_id
GROUP BY courses.course_id, courses.course_name;

SELECT
    courses.course_name,
    COUNT(enrollments.student_id) AS number_of_students
FROM courses
LEFT JOIN enrollments
    ON courses.course_id = enrollments.course_id
GROUP BY courses.course_id, courses.course_name
ORDER BY number_of_students DESC;
