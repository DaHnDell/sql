-- 이너 조인(교집합) // 사용 빈도로 치면 이게 조인의 90퍼정도 된다.
SELECT STUDNO, NAME, STUDENT.DEPTNO D1, DEPARTMENT.DEPTNO D2, DNAME 
FROM STUDENT, DEPARTMENT
WHERE STUDENT.DEPTNO = DEPARTMENT.DEPTNO;
-- WHERE STUDENT.DEPTNO <> DEPARTMENT.DEPTNO; // 두 개가 다를 때를 고르는 것

-- 아우터 조인(합집합) // 전체 합집합도 있지만, 부분집합 느낌도 됨. 

-- 학생 16명
-- 학과 7개
-- 카티션 프로덕트

SELECT STUDNO, NAME, S.DEPTNO, D.DNAME -- 후에 표준문법을 사용 할 경우 더 단축될 수 있다. AS 키워드를 통해 별칭을 붙이는 건. 오직 SELECT에서만.
FROM STUDENT s, DEPARTMENT d -- 대, 소문자 구분 정도는 알아서 해준다! 
WHERE S.DEPTNO = D.DEPTNO;
-- ++ AND 연산자를 사용해서 조건을 한번 더 달 수 있다.

-- 전인하 학생의 학번, 이름, 학과이름, 학과위치를 조회

SELECT STUDNO, NAME, DEPARTMENT.DNAME, LOC 
FROM STUDENT, DEPARTMENT
WHERE NAME = '전인하' AND STUDENT.DEPTNO = DEPARTMENT.DEPTNO ;

-- 몸무게가 80 KG 이상인 학생의 학번, 이름, 체중, 학과이름, 학과위치 조회

SELECT STUDENT.STUDNO, STUDENT.NAME, LOC, D.DNAME, STUDENT.WEIGHT 
FROM STUDENT, DEPARTMENT D
WHERE STUDENT.WEIGHT >= 80 AND STUDENT.DEPTNO = D.DEPTNO;


-- 1호관 소속의 학생의 학번, 이름, 학과 이름을 조회

SELECT STUDNO, D.LOC , S.NAME, D.DNAME 
FROM STUDENT S, DEPARTMENT d 
WHERE S.DEPTNO = D.DEPTNO AND LOC = '1호관'


-- ANSI 99 가 SQL 표준. 표준 문법에서는 JOIN 이라는 키워드를 사용하도록 권장한다.
SELECT STUDNO, NAME, DNAME 
FROM DEPARTMENT d
NATURAL JOIN STUDENT s 
-- CROSS JOIN STUDENT s // 카티션 곱을 원할 때는 CROSS 사용. 
WHERE LOC = '1호관';

-- 자연조인을 사용, 학번, 이름, 학과번호, 학과이름 조회

SELECT STUDNO, NAME, DEPTNO, DNAME
FROM STUDENT S
NATURAL JOIN DEPARTMENT d ;

SELECT  *
FROM STUDENT s , DEPARTMENT d 
WHERE S.DEPTNO = D.DEPTNO ;

-- JOIN 키워드와 USING을 사용, 혹은 ON 키워드를 사용하는 경우도 존재한다.
SELECT *
FROM STUDENT s 
JOIN DEPARTMENT D USING(DEPTNO);

SELECT S.DEPTNO -- 최소한 퀄리파이어를 사용해 주어야 ON에 대한 사용 조건이 특정된다. 
FROM STUDENT s 
JOIN DEPARTMENT d ON S.DEPTNO = D.DEPTNO; -- 언제나 칼럼명이 같을 수 없을 때 사용한다. 