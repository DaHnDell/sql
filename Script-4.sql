SELECT 1+1 
FROM 
WHERE 'SQL'='SQL   '; 

-- 결과 집합이 없음. false 값을 던져주기 때문.
-- 문자열 타입은 알아서 트림 작업을 해서 줄여줌. 


CREATE TABLE EX_TYPE(
	C CHAR(7)
	, V VARCHAR(7) -- 문자 타입의 경우 길이 생략은 할 수 없다. 
	, N NUMBER(5, 2) -- 숫자 타입의 경우 길이 생략은 해도 된다. 범위를 쓰지 않을 경우 범위를 최대로 땡겨쓰겠다 라는 뜻이다.
);

--DROP TABLE EX_TYPE;

SELECT *
FROM EX_TYPE
ORDER BY TO_NUMBER(C) ASC ; -- TO NUMBER를 사용해서 캐스팅 가능, 하지만 심각한 메모리 누수 발생

INSERT INTO EX_TYPE VALUES('1', 'SQL   ', 1); -- 데이타만을 저장하기 위한
INSERT INTO EX_TYPE VALUES('100', 'SQL   ', 100); -- 데이타만을 저장하기 위한
INSERT INTO EX_TYPE VALUES('2', 'SQL   ', 2); -- 데이타만을 저장하기 위한
INSERT INTO EX_TYPE VALUES('3', 'SQL   ', 3); -- 데이타만을 저장하기 위한
INSERT INTO EX_TYPE VALUES('20', 'SQL   ', 20); -- 데이타만을 저장하기 위한
 
DROP TABLE EX_TYPE

DELETE FROM EX_TYPE;

SELECT *
FROM EX_TYPE
WHERE C = V || '   '; -- C랑 V를 비교한다고 했을 때 참이 되려면 V 뒤에 공백을 4개 붙여야 함.

SELECT 3.1415922073 + 1 FROM DUAL; -- 숫자는 INT 도 LONG 도 DOUBLE 도 아닌 NUMBER다.


SELECT * FROM STUDENT; --

--현재 시간 정보 조회
SELECT SYSDATE  FROM DUAL


-- 로우아이디 찾기
SELECT STUDENT.*, ROWID FROM STUDENT; --

SELECT * FROM DEPARTMENT;
-- 공과대학 > 정보미디어학부, 전자공학 > 

SELECT  ROWNUM, STUDENT.*, ROWID FROM STUDENT
--;
WHERE ROWNUM > 5; -- 페이지의 개념 
--WHERE GRADE = 2;
-- ROWNUM = 조회된 것들에 대한 순번, 그리고 ROWNUM 자체를 조건으로도 쓸 수 있음. 

-- {1, 100, 2, 3, 20}

SELECT  * FROM EX_TYPE;

SELECT * FROM EX_TYPE;


-- 학생 테이블에서 1학년 학생의 학번 이름 학과번호 조회

SELECT STUDNO, NAME, DEPTNO
FROM STUDENT s 
WHERE GRADE  = '1'; -- 내부적인 형변환을 통해 넘버값으로 이용 가능. 

--  학번 이름 학년 학과번호 몸무게 조회, 단 70 이상 학생테이블에서.

SELECT STUDNO, NAME, GRADE, DEPTNO, WEIGHT
FROM STUDENT S
WHERE S.WEIGHT >=70;

-- 학번 이름 학년 학과번호 몸무게 조회, 단 몸무게 70 이상 + 1학년 학생테이블에서.

SELECT STUDNO, NAME, GRADE, DEPTNO, WEIGHT
FROM STUDENT S
WHERE S.WEIGHT >=70 
					AND S.GRADE = 1;

-- 이름 학년 학과번호 몸무게 조회, 단 몸무게 70 이상 이거나 1학년 학생테이블에서.

SELECT NAME, GRADE, DEPTNO, WEIGHT
FROM STUDENT S
WHERE S.WEIGHT >=70 
					OR S.GRADE = 1;
				
-- 학번 이름 몸무게, 체중이 50이상 70 이하인 사람만 
SELECT STUDNO, WEIGHT , NAME 
FROM STUDENT S
WHERE 
	S.WEIGHT BETWEEN 50 AND 70 
						AND S.GRADE = 1;
					
-- 학생테이블에서 81년에서 83년도에 태어난 학생의 이름과 생년월일 출력
					
SELECT STUDNO, BIRTHDATE
FROM STUDENT S
WHERE S.BIRTHDATE BETWEEN '81/01/01' AND '83/12/31'; 
-- 내가 한 실수 : BIRTHDATE = 81 AND BIRTHDATE = 83 
-- 이렇게 하는 것이 아니라 DATE 타입을 맞추기 위해서 전체 ''문자열 형식으로 출력해야 함.
-- 만약 연도만 뽑고 싶다면 TOCHAR를 

-- 이름, 학년, 학과번호 조회, 102번, 201번 학과만

SELECT  *
FROM STUDENT
WHERE DEPTNO IN(102, 201)  ;

-- 학생중 이름, 생년 81년에서 83년 사이에 태어난 학생의 이름과 생년월일 출력

SELECT TO_CHAR(BIRTHDATE, 'YY') YY, S.*
FROM STUDENT S
WHERE TO_CHAR(BIRTHDATE, 'YY') IN(81, 82, 83);

-- 이름, 학년, 학과번호 조회 김씨만

SELECT *
FROM STUDENT s
WHERE NAME LIKE'김___';
-- 김 뒤의 %는 뒤에 0 개 이하의 문자면 다 된다라는 뜻. 즉 이름이 김 한글자여도 반환, 김수한무거북이와두루미도 반환. 이름 중에 김이 들어가도 상관없음.
-- 일종의 정규표현식과 비슷함.


SELECT 2/0 FROM DUAL; -- 제수가 0과 같다(DEVISOR IS EQAUL)

-- 교수 테이블에서 이름, 직급, 보직수당 조회 (+보직수당이 있는 사람만)
SELECT ALL NAME , COMM, "POSITION"
FROM PROFESSOR P 
WHERE P.COMM IS NOT NULL;



-- 교수이름, 급여, 수당, 급여+수당 조회
SELECT NAME, COMM, SAL, NVL(COMM, 0) + SAL , NVL2(COMM, SAL+COMM , SAL) 
FROM PROFESSOR P;

-- NVL, NVL2 라는 계량 함수가 존재



-- 102번 학과 학생이면서 4학년이거나, 1학년
SELECT name, grade
FROM STUDENT s
WHERE s.DEPTNO = 102 AND (grade = 4 
or grade = 1);
-- 아니라면 이런 식으로도 가능 => And Grade in(1, 4);

-- 
CREATE TABLE stud_HEAVY AS 
SELECT *
FROM STUDENT
WHERE weight >=70 AND grade = '1';

CREATE TABLE stud_101 AS 
SELECT *
FROM STUDENT
WHERE deptno = 101 AND grade = '1';

SELECT * FROM tab;

-- 순서대로 값을 넣는다고 했을때 널값을 넣거나 그 자리에 맞는 데이터타입을 임의로 삽입
-- 이렇게 머징했을때 칼럼의 이름은 위에 것을 가져감.
SELECT STUDNO, NAME, NULL "GRADE" 
FROM STUD_HEAVY  
UNION 
SELECT STUDNO, NAME, GRADE 
FROM STUD_101  ;

-- UNION과 UNINON ALL 을 활용하여 학번 이름 조회(대상 테이블 : heavy, 101)
SELECT DISTINCT STUDNO, NAME FROM (
	SELECT STUDNO, NAME 
	FROM STUD_HEAVY 
	MINUS
	SELECT STUDNO, NAME
	FROM STUD_101 s
); 
-- 유니온 all을 사용할 경우 그야말로 단순합계이므로 중복값 역시도 리턴한다. 
-- 집합은 만든다고 했을 때 언제나 행 집합임을 유념해야 한다.
-- 마이너스는 앞부분에서 뒤를 빼는 경우.
-- 행의 갯수가 몇개 정도 될 것이다 하는 것이 데이터베이스를 익히는데 도움이 된다.
--


-- 학생 테이블에서 이름순으로 정렬, 이름, 학년, 전화번호 조회
SELECT NAME, GRADE, TEL  
FROM STUDENT
ORDER BY NAME DESC 


-- 학생 테이블에서 학년을 내림차순으로 정렬, 이름, 학년, 전화번호 조회

SELECT NAME, GRADE, TEL  
FROM STUDENT
ORDER BY GRADE DESC, NAME ASC; 				

-- 학생 테이블에서 학년을 내림차순으로 정렬, 같은 학년일 경우 이름으로 정렬
-- 이름, 학년, 전화번호 조회

SELECT *
FROM STUDENT S
ORDER BY PROFNO DESC;
-- 디센딩일 경우 NULL 값 먼저, 어센딩일 경우 NULL 값은 나중에.

SELECT STUDNO, NAME, PROFNO
FROM STUDENT 
ORDER BY PROFNO DESC;
-- 칼럼명을 이용해서 제어하는 형식은 모든 SQL 랭귀지에서 사용이 가능하다.
-- 소팅 기준은 언제나 셀렉트 절에서 선언한 칼럼명으로만 소팅이 가능.

SELECT AVG(SAL) 
FROM PROFESSOR;
-- 대표적인 복수 행 함수 중 하나인 AVG. 

-- 함수
-- 학생의 이름, 아이디를 조회, 단 아이디의 첫 글자는 대문자로.

SELECT NAME, USERID, INITCAP(USERID), UPPER(USERID), LOWER(USERID) -- 개별 호출 개별 반환 
FROM STUDENT;

-- 부서의 이름을 조회하고 이름의 길이와 바이트 갯수를 조회 
SELECT  DNAME, LENGTH(DNAME), LENGTHB(DNAME)
FROM DEPARTMENT;


-- 1학년 학생들의 생년월일, 태어난 달을 조회, 모든 주민번호를 등록

SELECT STUDNO, IDMUM, SUBSTR(IDNUM, 1, 6), SUBSTR(IDNU, 3 2) 
FREOM STUDENT
WHERE GRID;

-- 전화번호를 받는데, 끝의 4자리는 날리고 그자리를/
-- 단 마지막 네글자를 *로 변경

SELECT TEL
FROM STUDENT;

SELECT
	TEL,
--	CONCAT(SUBSTR(TEL, INSTR(TEL, '-', -7, 1), 7), '****') "NEWTEL"
	CONCAT(SUBSTR(TEL, 1, INSTR(TEL, '-')), '****')"NEWTEL"
FROM
	STUDENT;

-- 부서 테이블에서 부서이름 조회, 부서이름 내의 '과' 글자의 위치를 탐색

SELECT DNAME, INSTR(DNAME, '과', -3, 1)
FROM DEPARTMENT;

-- 교수의 직급의 왼쪽에 + 기호를 추가하여 10글자로, 아이디의 오른쪽에 *를 추가하여 12글자로 조회

SELECT *
FROM PROFESSOR;

SELECT
	POSITION,
	USERID,
	LPAD("POSITION", 10, '+'),
	RPAD(USERID, 12, '*')
FROM
	PROFESSOR;
 
SELECT
	'xyxxyyyyyxy',
	LTRIM('xyxxyyyyyxy', 'xy'),
	RTRIM('xyxxyyyyyxy', 'xy')
FROM
	DUAL;

-- 부서 테이블에서 부서 이름의 마지막 '과' 글자를 제거
SELECT DNAME, RTRIM(DNAME, '과') 
FROM DEPARTMENT;


-- 교수 일급계산, 한달은 22일으로 가정
-- 일급을 각각 소수점 첫째 자리에서 소수점 셋째 자리에서 반올림 + 10의 자리로 반올림
-- 일급을 각각 소수점 첫째 자리에서 소수점 셋째 자리에서 절삭

SELECT
	ROUND((SAL / 22)) "정수화",
	ROUND((SAL / 22), -1) "둘째 자리까지",
	ROUND((SAL / 22)) "10의 자리로 반올림",
	TRUNC((SAL / 22), 0) "소수점 버림",
	TRUNC((SAL / 22), 2) "둘째 자리까지 버림"
FROM
	PROFESSOR;

-- 교수번호 9908 교수님의 입사일, 입사 30일후, 입사 60일 후의 날짜를 조회

SELECT HIREDATE, HIREDATE + 30, HIREDATE +60
FROM PROFESSOR
WHERE PROFNO = 9908;
-- 타입이 시계모양이므로 날짜에 대한 계산이 수행 가능

-- 현재 날짜를 조회한다
SELECT SYSDATE FROM DUAL;

SELECT ROUND(MONTHS_BETWEEN(SYSDATE, '1997/12/08')) A
FROM DUAL;

-- 입사한지 120개월된 교수들을 조회 / 교수번호 / 입사일 / 입사일 + 6개월후 / 입사일부터 현재까지의 개월 수

SELECT
	PROFNO,
	HIREDATE,
	ADD_MONTHS(HIREDATE, 6) A ,
	MONTHS_BETWEEN(SYSDATE, HIREDATE) B 
FROM
	PROFESSOR
WHERE
	MONTHS_BETWEEN(SYSDATE, HIREDATE) < 320;
	

-- 오늘이 속한 달의 마지막 날짜와 다가오는 일요일 조회

SELECT
	SYSDATE,
	LAST_DAY(SYSDATE),
	NEXT_DAY(SYSDATE, ) 
FROM
	DUAL;
	

SELECT SYSDATE - 4/24, ROUND(SYSDATE),TRUNC(SYSDATE)
FROM DUAL;

- 오늘을 반올림. 날짜,
월,
연으로 반올림
--SELECT
--	SYSDATE ,
--	ROUND(SYSDATE, '100')Y,
--	ROUND(SYSDATE, MM) MONTH
--FROM DUAL;
--SELECT 
--SYSDATE 
--ROUND(SYSDATE(SYSDATE, "DPO") 
--ROUND 










-- 4 학년 학생을 조회\

SELECT * 
FROM STUDENT
WHERE GRADE = 4;














