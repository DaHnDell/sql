-- HR 초기 상태 lock -> unlock / pw 변경
--ALTER USER HR IDENTIFIED BY 1234 ACCOUNT UNLOCK;
-- SCOTT : 차후 적용 예정

-- SAMPLE
CREATE USER SAMPLE IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE TO SAMPLE;

GRANT CREATE VIEW TO SAMPLE;