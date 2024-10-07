SELECT STUDNO, NAME, ROWID, ROWNUM
FROM STUDENT s;
-- 로우아이디는 해시주소값이며 인덱스가 사용하고
-- 한번의 주소에 대한 해시값을 반환한다..

-- DEPARTMENT 테이블에 DNAME의 고유 인덱스 생성
CREATE INDEX IDX_DEPT_NAME ON DEPARTMENT(DNAME DESC)

SELECT /*+ INDEX(DEPARTMENT IDX_DEPT_NAME) */ *
FROM DEPARTMENT
WHERE DNAME IS NOT NULL;


-- 인덱스는 정렬과 검색에 있어 효율적이고 이에 따른 옵티마이저의 판단에 따라서 
-- 사용하는지 하지 않는지 정해진다. 
-- CTRL + SHIFT + / 할 경우 범위주석이 됨

