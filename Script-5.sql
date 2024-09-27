-- 명시적 데이터 타입 변환 
-- 사용자가 데이터 타입 변환 함수를 이용하여 명시적으로 데이터 타입을 변환 

-- TO_CHAR 숫자/날짜 타입을 문자로 변환 

-- oltp, olap 

--SELECT MONTH 
--FROM (2006-10-10,'MONTH');

-- 전인하 학생의 생년월일중 연, 월, 을 출력(YY-MM)

DROP TABLE STUD_101;
DROP TABLE STUD_HEAVY ;
DROP TABLE EX_TYPE;

SELECT BIRTHDATE, TO_CHAR(BIRTHDATE, 'YY-MM') 
FROM STUDENT
WHERE NAME = '전인하';


-- DAY MONTH DD YYYY 형식으로 102번 학과 학생의 생년월일 출력
-- 이런 식으로 처리할 경우 NLS값만 바뀌어도 문제없이 그대로 이어서 출력함.
SELECT BIRTHDATE, TO_CHAR(BIRTHDATE, 'DAY MON DD YYYY') 
FROM STUDENT
WHERE DEPTNO = 102;

-- 보직수당을 받는 교수들을 대상으로 급여를 더한 값에 12를 곱하여 ANUAL 이라는 이름으로
-- 연봉 계산을 하고 세 자리마다 쉼표로 표시하여라.

SELECT NAME, SAL, COMM, TO_CHAR((SAL+COMM) *12, '9,999') "ANUAL"
FROM PROFESSOR
WHERE COMM IS NOT NULL;	 

SELECT
	TO_NUMBER('1234')
--	,TO_NUMBER('ABCD') 문자열 문자열을 숫자로 어떻게 바꾸니!!!!!
	, TO_NUMBER('1234', '9,999') -- 위의 포메터를 같이 써주면 됨 
FROM
	DUAL;
	

-- NULLIF 함수


-- 학과번호가 101이면 컴퓨터공학과, 102면 멀티미디어학과, 201이면 전자공학과, 나머지는 기계공학과

SELECT
	STUDNO,
	NAME,
	DEPTNO,
	DECODE(DEPTNO, 
			101, '컴퓨터공학과',
			102, '멀티미디어학과',
			201, '전자공학과',
			'기계공학과') DNAME_CS
FROM STUDENT;
--WHERE --디코드 쓰지 마세요..속도도 느리고 가독성도 별로에요


--교수의 소속과에 따라 보너스 지급, 101학과일 경우 급여의 10%, 102학과는 20%, 201 학과는 30% 나머지는
SELECT
	PROFNO,
	NAME,
	SAL,
	DEPTNO,
	CASE
		WHEN DEPTNO = 101 THEN SAL * 0.1
		WHEN DEPTNO = 102 THEN SAL * 0.2
		WHEN DEPTNO = 201 THEN SAL * 0.3
		ELSE 0
	END BONUS,
	CASE DEPTNO 
		WHEN 101 THEN SAL*0.1
		WHEN 102 THEN SAL*0.2
		WHEN 201 THEN SAL*0.3
		ELSE 0
	END BONUS2
FROM PROFESSOR;


SELECT COUNT(*)
FROM STUDENT;

-- 그룹
-- 교수의 인원수를 조회

SELECT COUNT(*) 
FROM PROFESSOR
WHERE COMM IS NOT NULL;


-- 101학과 학생들의 몸무게 평균과 합계를 구하여라
SELECT COUNT(*), AVG(WEIGHT), SUM(WEIGHT), MAX(HEIGHT), MIN(HEIGHT) 
FROM STUDENT 
WHERE DEPTNO = 101;


-- 101학과 학생들의 몸무게 평균과 합계를 구하여라

-- 아래에서 그레이드를 사용했는데
SELECT
	GRADE,
	DEPTNO,
	COUNT(*)
FROM
	STUDENT
GROUP BY
	GRADE,
	DEPTNO
ORDER BY 
	1, 2;
	

-- 학과 번호별 교수의 인원수를 조회 

SELECT DEPTNO, COUNT(*), COUNT(COMM) 
FROM PROFESSOR
GROUP BY DEPTNO;

-- 학과 번호별 교수의 최대급여, 최소급여 조회
SELECT DEPTNO, MAX(SAL), MIN(SAL) 
FROM PROFESSOR
GROUP BY DEPTNO, SAL;

-- 전체 학생을 소속 학과별로 나누고, 같은 학과 학생은 다시 학년별로 그룹핑항, 학과와 학년별 인원수, 평균  몸무게

SELECT *
FROM STUDENT s ;

SELECT
	COUNT(DEPTNO),
	COUNT(GRADE), 
	DEPTNO,
	GRADE,
	COUNT(*),
	SUM(WEIGHT), AVG(WEIGHT)
FROM
	STUDENT
GROUP BY
	DEPTNO, GRADE 
ORDER BY 1, 2;


--SELECT COUNT(*) 학생수
--TO_CHAR((TO_CHAR(BIRTHDATE, 'YY-MM-DD'), 'Q'))


-- 꼭 봄여름가을겨울로 안나와도 되니까, 일단 구분이라도 해보라고..~~~~
SELECT
	CASE TO_CHAR(ADD_MONTHS( BIRTHDATE, -2), 'Q')
		WHEN '1' THEN 'SPRING'
		WHEN '2' THEN 'SUMMER'
		WHEN '3' THEN 'AUTUMN'
		WHEN '4' THEN 'WINTER'
	END SEASON
	, COUNT(*)
FROM STUDENT
GROUP BY TO_CHAR(ADD_MONTHS(BIRTHDATE, -2), 'Q')
ORDER BY TO_CHAR(ADD_MONTHS(BIRTHDATE, -2), 'Q');


-- 학생의 생년월일 (BIRTHDATE)를 기준으로 탄생 계절별 인원수 구하기

-- 수식이 칼럼이 되는 방식이 어렵다면, 이런 식의 서브쿼리도 활용이 가능하다.

SELECT A, COUNT(*) FROM(
	SELECT TO_CHAR(ADD_MONTHS(BIRTHDATE, -2), 'Q') A
FROM
	STUDENT

)
GROUP BY A;

SELECT STUDNO, BIRTHDATE
FROM STUDENT;



-- ROLLUP : 부분합 + 축 한방향
-- CUBE : 부분합, 양축

SELECT DEPTNO , "POSITION" , COUNT(*) 
FROM PROFESSOR
GROUP BY DEPTNO , "POSITION"
UNION
SELECT DEPTNO, NULL, COUNT(*) 
FROM PROFESSOR
GROUP BY DEPTNO 
ORDER BY 2
SELECT NULL, NULL, COUNT(*)
FROM PROFESSOR;

-- 부분합 메서드ROLLUP

SELECT DEPTNO , "POSITION", COUNT(*) 
FROM PROFESSOR
GROUP BY ROLLUP(DEPTNO, "POSITION");