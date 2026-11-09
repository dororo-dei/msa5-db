-- UPDATE 문
-- DML 중 하나로 저장되어 있는 기존 데이터를
-- 수정하기 위해 사용하는 쿼리
-- UPDATE 테이블명
-- SET
-- 	컬럼1 = 값1
-- 	[, 컬럼2 = 값2...]
-- 	[WHERE 절]

-- 100005 사원의 이름을 변경하고싶다.
UPDATE employees
SET
	`name` = '치이카와'
	, gender = 'F'
WHERE
	emp_id = 100005
;

-- 만약 WHERE절을 까먹었다면?
-- 전체 레코드가 다바뀐다 이유: 조건을 주지 않았기 때문.
-- 특정 레코드를 변경할 경우가 많기 때문에 UPDATE할 때 항시 주의할 것.

-- 100005번 사원의 생일을 '2020-01-01',
-- 이름을 '마이콜'로 변경해주세요.

UPDATE employees
SET
	`name` = '마이콜'
	, birth = '2020-01-01'
WHERE
	emp_id = 100005
;

SELECT * FROM employees WHERE emp_id = 100005;