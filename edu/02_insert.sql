-- INSERT 문
-- DML 중 하나로 신규 데이터를 저장하기 위해 사용하는 쿼리

-- INSERT INTO 테이블명 [(컬럼1, 컬럼2...)]
-- 소괄호 안은 생략이가능하나 굳이 생략하지 않는다

-- VALUES (값1, 값2...);
-- db의 특징: 컬럼의 순서성이 없다

INSERT INTO employees(
	`name`
	, birth
	, gender
	, hire_at
)
VALUES (
	'김도원'
	, '2000-01-01'
	, 'F'
	, NOW()
)
;

-- 복수의 레코드를 삽입하고 싶을 경우
INSERT INTO employees(`name`, birth, gender, hire_at)
VALUES ('최도원', '2000-01-01', 'F', NOW())
, ('최강재', '2000-01-01', 'M', NOW())
, ('최돌수', '2000-01-01', 'M', NOW())
;

-- SELECT INSERT
-- 조회된 결과를 가지고 INSERT를 실행
INSERT INTO title_emps (
	emp_id
	, title_code
	, start_at
	, end_at
	, created_at
	, updated_at
	, deleted_at
)
SELECT
	emp_id, 'T001', NOW(), NULL, NOW(),NOW(), NULL
FROM employees
WHERE
	emp_id > 100000
;