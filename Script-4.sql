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
SELECT NAME, COMM, SAL, NVL(COMM, 0) + SAL "SALCOMM", "POSITION", 
FROM PROFESSOR P;

-- NVL, NVL2 라는 계량 함수가 존재




				
