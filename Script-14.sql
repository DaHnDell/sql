-- sql prac



-- 학생테이블의 모든 데이터 출력
SELECT *
FROM STUDENT;

-- 각 학생의 번호, 이름, 생일 출력
SELECT STUDNO, NAME, BIRTHDATE
FROM STUDENT ;

-- 학과, 중복 없이
SELECT DISTINCT DEPTNO
FROM STUDENT;

-- 4학년 이상인 사원의 이름 및 학번을 출력
SELECT NAME, STUDNO 
FROM STUDENT 
WHERE GRADE >= 4;

-- 101번 학과에 속하는 모든 학생의 이름과 주민번호를 출력하되, 이름을 정렬한다.
SELECT NAME, IDNUM 
FROM STUDENT 
WHERE STUDENT.DEPTNO = 101
ORDER BY 1;

ins