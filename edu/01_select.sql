-- SELECT 문 (대소문자 상관없으나 DBMS마다 관습적으로 사용하는 것들이 다르다)
-- DML 중 하나로, 저장되어 있는 데이터를
-- 조회하기 위해 사용하는 쿼리

-- 조회한 데이터 중 특정 컬럼만 출력
SELECT
	emp_id  -- 보통 예약어는 두단어 이상으로 사용하지 않기 때문에 백틱으로 감쌀 필요는 없다
	, `name` -- 백틱(`)으로 감싸면, SQL에서 사용하는 예약어(해당 기술에서 사용하는 변수명)가 아니라 컬럼으로 인식시킨다
	, gender -- del v2.0
	birth -- add v2.0
FROM employees -- 테이블명을 작성해준다
; -- 세미콜론 필수

SELECT
	emp_id,  -- 보통 예약어는 두단어 이상으로 사용하지 않기 때문에 백틱으로 감쌀 필요는 없다
	`name`, -- 백틱(`)으로 감싸면, SQL에서 사용하는 예약어(해당 기술에서 사용하는 변수명)가 아니라 컬럼으로 인식시킨다
	gender, -- del v2.0
	gender, -- add v2.0
	birth -- add v2.0
FROM employees -- 테이블명을 작성해준다
; -- 세미콜론 필수

-- 실행, 선택실행, 현재 쿼리 실행
-- 실행? 여러개의 SQL이 있을경우 전부 실행

-- Asterrisk (*) : 모든 컬럼 조회
FROM employees
;

-- WHERE 절: 특정 컬럼의 값이 조건에 맞는 데이터만 조회 => 필터링
-- 사번이 10009인 사원의 모든 정보를 조회해 주세요.
SELECT 
	*
FROM employees
WHERE
	emp_id = 10009 -- db에서 =하나는 비교 연산자이다 
;

-- 사원명이 "박보람"인 사원의 정보를 조회해주세요
SELECT
	*
FROM employees
WHERE	
	`name` = "박보람"
;

-- 생일이2000-01-01 이후인 사원 모두 찾아주세요.
SELECT
	*
FROM	employees
WHERE
	birth >= '2000-01-01' -- 문자열로 준다
;

-- 퇴사하지 않은 사원 정보 다 주세요.
SELECT
	*
FROM employees
WHERE
	fire_at IS NULL
;

-- 퇴사한  사원 정보 다 주세요.
SELECT
	*
FROM employees
WHERE
	fire_at IS NOT NULL
;