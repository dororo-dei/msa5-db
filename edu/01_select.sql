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

-- 1990년생인 사원을 조회해 주세요.
SELECT
	*
FROM employees
WHERE	
	birth >= '1990-01-01'
	AND birth <= '1990-12-29'
;
-- 위와 같은 조건에서 마이크로 초까지 시간이 담겨야한다면?
SELECT
	*
FROM employees
WHERE	
	birth >= '1990-01-01 00:00:00'
	AND birth < '1990-01-01 00:00:00'
;

-- 이름이 '김철수'또는 '정유리'인 사원을 조회해주세요
SELECT
	*
FROM employees
WHERE
	`name` = '김철수'	
	OR `name` = '정유리'
;

-- 1990년생 이거나, 이름이 '정유리'인 사원을 조회해 주세요
SELECT
	*
FROM employees
WHERE
	(birth >= '1990-01-01'
	AND birth <= '1990-12-31')
	OR `name` = '정유리'
;

SELECT
	*
FROM employees
WHERE
	birth >= '1990-01-01'
	AND
	( `name` = '정유리'
	OR `name` = '박보람'
	)
;

-- BETWEEN 연산자: 지정한 범위 내의 데이터를 조회
SELECT
	*
FROM employees
WHERE
-- 	birth >= '1990-01-01'
-- 	AND birth <= '1990-12-31'
	birth BETWEEN '1990-01-01' AND '1990-12-31'
;

-- IN 연산자 : 다수의 지정한 값과 일치하는 데이터를 조회
SELECT
	*
FROM employees
WHERE
-- 	`name` = '박보람'
-- 	OR `name` = '정유리'
	`name` IN('박보람','정유리')
;

-- 사번이 10001, 10005, 10006인 사원의 모든 정보 조회
SELECT
	*
FROM employees
WHERE 
	emp_id IN(10001,10005,10006)
;

-- LIKE 절: 문자열의 내용을 조회
-- %: 글자 수와 상관없이 조회할 경우 사용
-- 이름이 '우'로 끝나는 사원 조회
SELECT
	*
FROM employees
WHERE
 `name` LIKE '%우'
--  `name` LIKE '우%' -- '우'로 시작하는 사원 조회
--  `name` LIKE '%우%'  -- '우'가 포함된 사원 조회
 ;
 
 (_): 언더바의 개수만큼 글자수를 허용해서 조회
SELECT
	*
FROM employees
WHERE
 `name` = LIKE '_우%'
;
 
-- ORDER BY 절 : 조회환 데이터를 정렬
SELECT
	*
FROM employees
ORDER BY `name` DESC, birth
;

-- LIMIT 키워드, OFFSET 키워드 : 출력의 개수를 제한하여 조회
SELECT
	*
FROM employees
-- LIMIT 5 OFFSET 10
LIMIT 10, 5
;

-- 집계함수 (통계내기 위해 사용하는 연산들의 모임)

-- SUM(컬럼) : 조회 된 해당 컬럼의 모든 값의 합계를 반환하는 함수
-- 전 사원의 현재 급여 합계를 조회해 주세요
SELECT
	SUM(salary) sum_sal
FROM salaries
WHERE
	end_at IS NULL
;

-- MAX(컬럼)
SELECT
	MAX(salary) max_sal
FROM salaries
WHERE
	end_at IS NULL
;

-- MIN(컬럼)
SELECT
	MIN(salary) min_sal
FROM salaries
WHERE
	end_at IS NULL
;

-- AVG(컬럼)
SELECT
	AVG(salary) avg_sal
FROM salaries
WHERE
	end_at IS NULL
;

-- COUNT(컬럼)
-- 컬럼명 삽입 시 검색 결과 중 해당 컬럼의 값이
-- NULL이 아닌 레코드의 총 수를 출력
-- 현재 재직 중인 사원 수를 구해주세요.
SELECT
	COUNT(NAME),
	COUNT(*) cnt
FROM employees
WHERE
	fire_at IS NULL
;

-- DISTINCT 키워드 : 검색결과에서 중복된 레코드 없이 출력
SELECT DISTINCT
	emp_id,
	`name`
FROM employees
ORDER BY `name`
;

-- GROUP BY 절, HAVING 절
-- 그룹으로 묶어서 조회

-- 부서별 사원수?
SELECT
-- GROUP BY 절에서 사용한 컬럼과
-- 집계함수만 작성해야한다. (SQL 표준 문법)	
	dept_code
	,COUNT(*) cnt_emp
FROM department_emps
WHERE
	end_at IS NULL
GROUP BY dept_code -- 오동작할 수 있음. 부서별 묶었는데 사원 id 표시해야함 <- 이상함
;

-- 직급별 사원수가 10000만명 이상인 직급을 조회해주세요
SELECT
	title_code
	,COUNT(*) cnt_emp
FROM title_emps
WHERE
	end_at IS NULL
GROUP BY title_code
HAVING cnt_emp >= 10000
;