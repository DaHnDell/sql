-- 주소록 테이블 생성
-- ID VARCHAR(100), name varchar(100)

CREATE TABLE ADDR(
	ID VARCHAR2(100),
	NAME VARCHAR2(100)
);

ALTER TABLE ADDR ADD (BIRTH DATE);

SELECT * FROM ADDR2;

-- 주소록에 COMMENTS 칼럼 추가 VARCHAR(200 ) 기본값 'NO COMMENT'

ALTER TABLE ADDR ADD(COMMNETS VARCHAR2(200) DEFAULT 'NO COMMENT');

INSERT INTO ADDR(ID) VALUES ('ID1');

-- 주소록에 COMMENTS 컬럼 삭제

ALTER TABLE ADDR DROP(COMMNETS);

-- 주소록 ID 컬럼의 크기를 1BYTE로 변경 

ALTER TABLE ADDR MODIFY ID VARCHAR(50);

RENAME ADDR TO ADDR2;

-- ADDR2 테이블에다가 '주소록' 이라는 COMMENT 추가
COMMENT ON TABLE ADDR2 IS '주소록'

-- ADDR2의 NAME 칼럼에 '이름' 이라는 COMMNET 추가 
COMMENT ON COLUMN ADDR2.NAME IS '이름';

-- SUBJECT 테이블 + SUBNO 번호 + SUBNAME 이름 + TERM(1학기, 2학기) + TYPE 필수 여부 CHAR(1)

CREATE TABLE SUBJECT(
	SUBNO NUMBER CONSTRAINT SUBJECT_PK PRIMARY KEY,
	SUBNAME VARCHAR(200) CONSTRAINT SUBNAME_NN NOT NULL,
	TERM CHAR(1) CONSTRAINT TERM_CK CHECK (TERM IN  ('1', '2')),
	TYPE CHAR(1)
);
-- CREATE 가 아니라 ALTER로 해야만 함
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_PK PRIMARY KEY(STUDNO);

CREATE TABLE SUGANG(
	STUDNO CONSTRAINT SUGANG_STUDNO_FK REFERENCES STUDENT, 
	SUBNO NUMBER, 
	REGDATE DATE,
	RESULT NUMBER(3),
	CONSTRAINT SUGANG_SUBNO_FK FOREIGN KEY(SUBNO) REFERENCES SUBJECT(SUBNO),
	CONSTRAINT SUGANG_PK PRIMARY KEY(STUDNO, SUBNO)
)


-- 학과 테이블에 제약조건 넣기

-- PK : DEPTNO, DNAME : NN, COLLEGE<>DEPTNO FK

ALTER TABLE DEPARTMENT MODIFY(DEPTNO CONSTRAINT DEPARTMENT_PK PRIMARY KEY);
ALTER TABLE DEPARTMENT MODIFY(DNAME NOT NULL);
ALTER TABLE DEPARTMENT MODIFY(COLLEGE REFERENCES DEPARTMENT(DEPTNO));

SELECT * FROM DEPARTMENT d ;

--  교수 테이블에 전제 제약조건 넣기
-- PK, NN, UINIQUE

ALTER TABLE PROFESSOR ADD CONSTRAINT PROFESSOR_PK PRIMARY KEY(PROFNO);
ALTER TABLE PROFESSOR MODIFY(NAME NOT NULL);
ALTER TABLE PROFESSOR ADD CONSTRAINT PROF_USERID_UK UNIQUE(USERID);
ALTER TABLE PROFESSOR ADD CONSTRAINT PROFESSOR;
ALTER TABLE PROFESSOR ADD FOREIGN KEY(DEPTNO) REFERENCES DEPARTMENT;

-- 학생
-- 이름 아이디 주민번호 DEPTNO

SELECT * FROM STUDENT s ;

ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_PK PRIMARY KEY(STUDNO);
ALTER TABLE STUDENT MODIFY(NAME NOT NULL);
ALTER TABLE STUDENT ADD CONSTRAINT STUD_USERID_UK UNIQUE(USERID);
ALTER TABLE STUDENT ADD FOREIGN KEY(DEPTNO) REFERENCES DEPARTMENT;
ALTER TABLE STUDENT ADD FOREIGN KEY(PROFNO) REFERENCES PROFESSOR;

SELECT * FROM STUDENT s ;

DROP TABLE STUDENT CASCADE CONSTRAINTS PURGE;


