--query-1
--Display all students and the courses they are enrolled in.
SELECT s.student_name,c.course_name
FROM students s
LEFT JOIN enrollments e ON s.student_id=e.student_id
LEFT JOIN courses c ON e.course_id=c.course_id;

--query-2
--Find all courses that currently have no students enrolled.
SELECT c.course_id,c.course_name
FROM courses c
LEFT JOIN enrollments e ON c.course_id=e.course_id
WHERE e.course_id IS NULL;

--query-3
--Display all instructors and the courses they teach.
SELECT i.instructor_name,c.course_name
FROM instructors i
LEFT JOIN courses c ON i.instructor_id=c.instructor_id;

--query-4
--Find all courses without an instructor.
SELECT course_id,course_name
FROM courses
WHERE instructor_id IS NULL;

--query-5
--Display all students and enrollment information using RIGHT JOIN.
SELECT s.student_name,e.enrollment_id,e.course_id,e.enrollment_date
FROM students s
RIGHT JOIN enrollments e ON s.student_id=e.student_id;

--query-6
--Find students not enrolled in any course.
SELECT s.student_id,s.student_name
FROM students s
LEFT JOIN enrollments e ON s.student_id=e.student_id
WHERE e.student_id IS NULL;

--query-7
--Display all students and enrollments using FULL OUTER JOIN.
SELECT s.student_name,e.enrollment_id,e.course_id,e.enrollment_date
FROM students s
FULL OUTER JOIN enrollments e ON s.student_id=e.student_id;

--query-8
--Find courses never enrolled by any student.
SELECT c.course_id,c.course_name
FROM courses c
LEFT JOIN enrollments e ON c.course_id=e.course_id
WHERE e.course_id IS NULL;

--query-9
--Display all instructors and courses using FULL OUTER JOIN.
SELECT i.instructor_name,c.course_name
FROM instructors i
FULL OUTER JOIN courses c ON i.instructor_id=c.instructor_id;

--query-10
--Display student name, course name, and instructor name.
SELECT s.student_name,c.course_name,i.instructor_name
FROM students s
LEFT JOIN enrollments e ON s.student_id=e.student_id
LEFT JOIN courses c ON e.course_id=c.course_id
LEFT JOIN instructors i ON c.instructor_id=i.instructor_id;

--query-11
--Display every student with every course.
SELECT s.student_name,c.course_name
FROM students s
CROSS JOIN courses c;