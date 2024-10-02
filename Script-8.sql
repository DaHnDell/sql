-- 사용자 아이디가 jun123인 학생과 같은 학년인 학생의 학번, 이름, 학년을 조회

SELECT
	STUDNO,
	NAME,
	GRADE
FROM
	STUDENT s
WHERE
	GRADE = 
(
	SELECT
		GRADE
	FROM
		STUDENT
	WHERE
		USERID = 'jun123');
		
	
-- 101번 학과 학생들의 평균 몸무게보다 적은 몸무게를 가진 학생의 학번, 학과번호 몸무게를 조회

SELECT
	STUDNO,
	DEPTNO,
	WEIGHT
FROM
	STUDENT
WHERE
	WEIGHT<
(
	SELECT
		AVG(WEIGHT)
	FROM
		STUDENT
	WHERE
		DEPTNO = 101);

	
-- 20101번 학생의 학년과 동일하고 20101 학생보다 키가 큰 학생의 이름, 학년 키를 조회
--	
--SELECT NAME, GRADE, HEIGHT
--FROM STUDENT
--WHERE GRADE (
--WHERE HEIGHT >(
--SELECT HEIGHT 
--FROM STUDENT
--WHERE STUDNO = 20101));
	
	
-- 정보미디어학부에 소속된 학생의 학번, 이름, 학과 번호
	

SELECT
	DEPTNO, NAME, STUDNO 
FROM
	STUDENT
WHERE
	DEPTNO =  ANY (
	SELECT
		DEPTNO 
	FROM
		DEPARTMENT
	WHERE
		COLLEGE = (
		SELECT
			DEPTNO
		FROM
			DEPARTMENT
		WHERE
			DNAME = '정보미디어학부'
)
);


-- 비교 연산자는 단일 행으로만 가능
SELECT
	*
FROM
	STUDENT
WHERE
	HEIGHT > SOME (
	SELECT
		HEIGHT
	FROM
		STUDENT
	WHERE
		GRADE = 4

)

SELECT
	HEIGHT
FROM
	STUDENT
WHERE
	HEIGHT > (
	SELECT
		MIN(HEIGHT)
	FROM
		STUDENT
	WHERE
		GRADE = 4
);

-- 4학년 학생중에서 키가 가장 큰 학생을 조회, 학번, 이름 키


SELECT
	*
FROM
	STUDENT
WHERE
	HEIGHT > ALL(
	SELECT
		HEIGHT
	FROM
		STUDENT
	WHERE GRADE = 4
		);

SELECT STUDNO, NAME, HEIGHT
FROM STUDENT
WHERE HEIGHT > (
	SELECT MAX(HEIGHT)
	FROM STUDENT 
	WHERE GRADE = 4
);
	

-- 보직수당을 받는 교수가 존재한다면 교수들의 교수번호, 이름, 급여, 수당, 급여 + 수당을 조회


SELECT PROFNO, USERID, COMM, SAL + NVL(COMM, 0) SALCOM
FROM PROFESSOR p 
WHERE EXISTS (
	SELECT *
	FROM PROFESSOR 
--	WHERE COMM IS NOT NULL 
	WHERE 1 =1 
)


SELECT GRADE, WEIGHT, NAME 
FROM STUDENT 
WHERE (GRADE, WEIGHT) IN (
	SELECT GRADE, MIN(WEIGHT) 
	FROM STUDENT 
	GROUP BY GRADE	
)
ORDER BY 1
MINUS
SELECT NAME, GRADE, WEIGHT 
FROM STUDENT
WHERE GRADE IN (
SELECT DISTINCT GRADE
FROM STUDENT
)
AND WEIGHT IN (
	SELECT MIN(WEIGHT)
	FROM STUDENT s 
	GROUP BY GRADE 
);


SELECT MIN(WEIGHT)
FROM STUDENT s 
GROUP BY GRADE;


-- 학과별 평균 키 보다 큰 학생의 이름, 학과번호, 키를 조회

SELECT NAME, HEIGHT
FROM STUDENT s1 
WHERE HEIGHT > (
	SELECT AVG(HEIGHT)
	FROM STUDENT S2
	WHERE S2.DEPTNO = S1.DEPTNO 
)


SELECT DEPTNO, AVG(HEIGHT)
FROM STUDENT S2
GROUP BY DEPTNO 


SELECT MAX(SUN), MAX(MON), MAX(TUE), MAX(WED) , MAX(THU), MAX(FRI), MAX(SAT) FROM (
SELECT 1 SUN, NULL MON, NULL TUE, NULL WED, NULL THU, NULL FRI, NULL SAT FROM DUAL
UNION
SELECT NULL, 2, NULL, NULL, NULL, NULL, NULL FROM DUAL
UNION
SELECT NULL, NULL, 3, NULL, NULL, NULL, NULL FROM DUAL
UNION
SELECT NULL, NULL, NULL, 4, NULL, NULL, NULL FROM DUAL
UNION
SELECT NULL, NULL, NULL, NULL, 5, NULL, NULL FROM DUAL
UNION
SELECT NULL, NULL, NULL, NULL, NULL, 6, NULL FROM DUAL
UNION
SELECT NULL, NULL, NULL, NULL, NULL, NULL, 7 FROM DUAL
)
SELECT  TO_CHAR(TO_DATE('2024-09-01','YYYY-MM-DD'), 'W')FROM DUAL; -- 주차 계산

SELECT 
	MAX (DECODE(MOD(RN, 7), 1, RN)) SUN	
	,
	MAX (DECODE(MOD(RN, 7), 2, RN)) MON	
	,
	MAX (DECODE(MOD(RN, 7), 3, RN)) TUE	
	,
	MAX (DECODE(MOD(RN, 7), 4, RN)) WED	
	,
	MAX (DECODE(MOD(RN, 7), 5, RN)) THU	
	,
	MAX (DECODE(MOD(RN, 7), 6, RN)) FRI	
	,
	MAX (DECODE(MOD(RN, 7), 0, RN)) SAT
FROM
	(
	SELECT
		ROWNUM RN,
		TO_CHAR(TO_DATE('2024-09-' || LTRIM(TO_CHAR(ROWNUM, '00'))), 'W') WEEK 
	FROM DICT
	WHERE
		ROWNUM <= TO_CHAR(LAST_DAY(TO_DATE('2024 - 09', 'YYYY-MM')), 'DD')
)
GROUP BY WEEK
ORDER BY WEEK;



-- DML
-- 홍길동 데이터 입력
-- 학번 : 10110, 이름 : '홍길동', ID : 'HONG', GRADE : '1', IDNUM : '8510101010101', BIRTHDATE : '85/10/10', TEL : '041)123-4567', 
-- HEIGHT : 170, WEIGHT : 70, DEPTNO : 101, PROFNO : 9903

INSERT INTO STUDENT
VALUES (10110, '홍길동', 'HONG', '1', '8510101010101', '85/10/10', '041)123-4567', 170, 70, 101, 9903);

SELECT COLUMN_NAME, COLUMN_ID FROM USER_TAB_COLS WHERE TABLE_NAME = 'STUDENT';

SELECT * FROM DICT WHERE TABLE_NAME LIKE 'ALL_%COL%';

SELECT * FROM STUDENT;

ROLLBACK;

COMMIT;



-- 학과 테이블에 DEPTNO : 300, DNAME : 생명공학부를 추가
INSERT INTO DEPARTMENT(DEPTNO, DNAME, COLLEGE, LOC) VALUES (300, '생명공학부', NULL, '');

SELECT * FROM DEPARTMENT d ;

SELECT * FROM PROFESSOR 

-- US_EN (미국 영어), UK_EN(영어), 
INSERT INTO PROFESSOR (PROFNO , NAME, POSTION, HIREDATE, DEPTNO) VALUES (9920, '최윤식', '조교수', TO_DATE('2006-01-01', 'YYYY-MM-DD', 102);

DELETE PROFESSOR WHERE PROFNO = 9910

INSERT INTO PROFESSOR VALUES (9910, '백미선', 'WHITE', '전임강사', 200, TRUNC(SYSDATE), 10, 101);

COMMIT;

-- 학생과 STUDENTS  와 동일한 TABLE 생성.

CREATE TABLE T_STUDENT AS
SELECT * FROM STUDENT WHERE 3 = 0 ;


SELECT * FROM T_STUDENT
-- 추후에 배울 VIEW 컨텐츠를 배울 때에도 자주 사용하게 됨. 


INSERT INTO T_STUDENT 
SELECT * FROM STUDENT s; 


SELECT * FROM PROFESSOR;
DELETE FROM PROFESSOR p WHERE POSITION = '조교수';

-- SWQUENCE
-- 게시판 용 테이블 생성

CREATE TABLE BOARD (
	NO NUMBER PRIMARY KEY,
	TITLE VARCHAR(4000),
	CONTENT CLOB,
	REGDATE DATE DEFAULT SYSDATE,
	WRITER VARCHAR(1000)
);
CREATE SEQUENCE SEQ_BOARD;

DROP TABLE BOARD;

INSERT INTO BOARD (NO, TITLE, CONTENT, WRITER) VALUES(2, '제목', '내용', '작성자' );
SELECT ROWNUM, B * FROM BOARD B;

COMMIT;

INSERT INTO BOARD (NO, TITLE, CONTENT, WRITER) 
SELECT SEQ_BOARD.NEXTVAL NO, TITLE, CONTENT, WRITER FROM BOARD;