SELECT STUDNO, NAME, ROWID, ROWNUM
FROM STUDENT s;
-- 로우아이디는 해시주소값이며 인덱스가 사용하고
-- 한번의 주소에 대한 해시값을 반환한다..

-- DEPARTMENT 테이블에 DNAME의 고유 인덱스 생성
CREATE UNIQUE INDEX IDX_DEPT_NAME ON DEPARTMENT(DNAME);
CREATE INDEX IDX_DEPT_NO ON DEPARTMENT(DEPTNO DESC);

SELECT /*+ INDEX(DEPARTMENT IDX_DEPT_NAME) */ *
FROM DEPARTMENT;
--WHERE DNAME IS NOT NULL;

SELECT /*+ INDEX(DEPARTMENT IDX_DEPT_NO) */ *
FROM DEPARTMENT;
--WHERE DNAME IS NOT NULL;


-- 인덱스는 정렬과 검색에 있어 효율적이고 이에 따른 옵티마이저의 판단에 따라서 
-- 사용하는지 하지 않는지 정해진다. 
-- CTRL + SHIFT + / 할 경우 범위주석이 됨

DROP INDEX IDX_DEPT_NAME;


-- STUDENT BIRTHDATE 비고유 인덱스 생성
-- 생년월일의 경우 중복값이 있을 수도 있으니 비고유 인덱스로 생성
CREATE INDEX IDX_STUD_BIRTHDATE ON STUDENT(BIRTHDATE);

-- STUDENT 테이블의 DEPTNO, GRADE의 결합인덱스 생성
SELECT DISTINCT GRADE, DEPTNO FROM STUDENT s;

-- 중복된 값이 있으면 고유값이 걸리지 않음
CREATE INDEX IDX_STUD_GRADE_DEPTNO ON STUDENT(DEPTNO, GRADE DESC);

SELECT * FROM STUDENT s ;


CREATE VIEW VIEW_STUD AS 
SELECT * FROM (SELECT STUDNO, NAME, DEPTNO FROM STUDENT);

SELECT DEPTNO, COUNT(*)
FROM VIEW_STUD
WHERE DEPTNO <> 201
GROUP BY DEPTNO;

INSERT INTO VIEW_STUD VALUES(12345, '홍길동', NULL);

SELECT * FROM VIEW_STUD;
SELECT * FROM STUDENT s ;

SELECT * FROM STUDENM;

CREATE FORCE VIEW VIEW_STUD2 AS
SELECT * FROM STD

-- 학번, 이름, 학과번호, 학과 이름으로 VIEW_STUD_DEPT 튜플 생성
SELECT * FROM STUDENT s ;

CREATE VIEW VIEW_STUD_DEPTNO AS 
SELECT STUDNO, NAME, D.DEPTNO , DNAME
FROM STUDENT S JOIN DEPARTMENT D ON S.DEPTNO = D.DEPTNO;


SELECT * FROM VIEW_STUD_DEPTNO;
DROP VIEW VIEW_STUD_DEPTNO

-- 11111, 고길동, 101, 컴퓨터공학과

INSERT INTO VIEW_STUD_DEPTNO VALUES(11111, '고길동', 101);
INSERT INTO VIEW_STUD_DEPT VALUES(11111, '고길동', 101, '컴퓨터공학과');

 
SELECT STUDNO, NAME, DEPTNO, DNAME
FROM STUDENT s NATURAL JOIN DEPARTMENT d;

-- 학과별 인원수를 조회하여 VIEW
CREATE VIEW VIEW_STUD_DEPT2(DNO, CNT) AS
SELECT DEPTNO, COUNT(*) 
FROM STUDENT 
GROUP BY DEPTNO
ORDER BY 1;

SELECT * FROM VIEW_STUD_DEPT2;

SELECT * FROM BOARD ;
DROP TABLE BOARD;

CREATE TABLE SAMPLE.BOARD (
	"NO" NUMBER,
	TITLE VARCHAR2(4000),
	CONTENT CLOB,
	REGDATE DATE DEFAULT SYSDATE,
	WRITER VARCHAR2(1000),
	CONSTRAINT SYS_C007003 PRIMARY KEY ("NO")
);
CREATE UNIQUE INDEX SYS_C007003 ON SAMPLE.BOARD ("NO");

DROP SEQUENCE SEQ_BOARD;
CREATE SEQUENCE SEQ_BOARD;

SELECT * FROM BOARD ;

INSERT INTO BOARD(NO, TITLE, CONTENT, WRITER) 
VALUES (SEQ_BOARD.NEXTVAL, '제목' || SEQ_BOARD.CURRVAL, '내용', '작성자')

INSERT INTO BOARD(NO, TITLE, CONTENT, WRITER)
SELECT SEQ_BOARD.NEXTVAL, TITLE, CONTENT, WRITER FROM BOARD;

-- 기준은 언제나 PK가 되어야 좋다.
-- 그러나 가변적 요소를 이용하여 정렬하면 좋지 않다.

SELECT * FROM (
	SELECT ROWNUM RN, A.*
	FROM (
		SELECT B.*
		FROM BOARD B
		ORDER BY 1 DESC
) A 
)
WHERE
	ROWNUM <= 20 AND RN > (4-1) * 10;

SELECT * FROM (
	SELECT /*+ INDEX_DESC(B SYS_C007003)*/ B.*, ROWNUM RN
	FROM BOARD B
	WHERE NO > 0
);

WITH A AS ( 
	SELECT /*+ INDEX_DESC(B SYS_C007003)*/ B.*, ROWNUM RN
	FROM BOARD B
	WHERE NO > 0
)
SELECT * 
FROM A
WHERE ROWNUM <= 10
AND RN > 10;

CREATE SYNONYM EMP FOR HR.EMPLOYEES;

SELECT * FROM HR.EMPLOYEES;
SELECT * FROM EMP;

SELECT * FROM STU;


-- 사전
-- USER, ALL, DBA로 시작한다. 

SELECT OWNER FROM ALL_TABLES WHERE OWNER = 'SAMPLE';


SELECT  TABLE_NAME FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'BOARD';

SELECT * FROM USER_CONSTRAINTS;
-- P = PRIMARY, CHECK = NOT NULL, R = RELATIONAL


-- ALL 로 시작하는 경우에는
-- TABLES, TAB COLUMNS 




