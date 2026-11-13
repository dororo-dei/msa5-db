-- ------
-- INDEX
-- ------

-- INDEX 확인
SHOW INDEX FROM employees;

-- 0.03초 정도?
SELECT * FROM employees WHERE `name` = '이미경';

-- INDEX 생성
ALTER TABLE employees
ADD INDEX idx_employees_name (`name`);

-- INDEX 제거
ALTER TABLE employees
DROP INDEX idx_employees_name;

-- -------------------------------------------------------------------------------
-- 파티셔닝
-- 우리 유저가 많다. 한 테이블에 넣으면 레코드가 많다.
-- 예를 들어 유저 PK 가장 마지막 번호가 1~0까지 나오니까 유저테이블을 10개를 만든다
-- 끝번호가 0인 친구는 유저 0에담고 1이면 유저2에담고 이런식으로 파티셔닝을 해서
-- 자바에서도 해야하기때문에 고급기술이다.
-- -------------------------------------------------------------------------------