-- subQuery

-- -----------------
-- WHERE 절에서 사용
-- -----------------
-- 단일 행 서브쿼리
-- 서브쿼리가 단일 행 비교 연산자와 함께 사용할 때는
-- 반드시 서브쿼리의 결과 수가 1건 이하여야 한다.
-- 만약에 2건 이상일 경우 오류가 발생

-- D001 부서장의 사번과 이름을 출력
SELECT 
	emp.emp_id
	, emp.`name`
FROM employees emp
-- 쿼리에서 사용하는 테이블이 다수라면 별칭을 넣어준다
-- 별칭은 3글자 혹은 4글자로 짓는다
WHERE
	emp.emp_id = (
	-- 'D001'의 현재 부서장 사번
		SELECT
			depm.emp_id
		FROM department_managers depm
		WHERE
			dept_code = 'D001'
			AND end_at IS NULL	
	)
;

-- 다중 행 서브쿼리
-- 서브 쿼리의 결과가 2건 이상을 반환할 경우
-- 반드시 다중 행 비교연산자를 사용(IN, ALL, ANY, SOME, EXISTS)
-- 현재 부서장인 사원의 사번과 이름을 출력
SELECT
	emp.emp_id
	,emp.`name`
FROM employees emp
WHERE
	emp.emp_id IN (
		SELECT
			depm.emp_id
		FROM department_managers depm
		WHERE
			depm.end_at IS NULL
	)
;

-- 다중 열 서브쿼리
-- 현재 'D002' 부서장이 해당 부서에 소속 된 날짜를 출력

SELECT
	depe.start_at
FROM department_emps  depe
WHERE
	(depe.emp_id, depe.dept_code) IN (
	SELECT
		depm.emp_id
		, depm.dept_code
	FROM department_managers depm
	WHERE
		depm.dept_code = 'D002'
		AND depm.end_at IS NULL
	)
;

-- 연관 서브쿼리
-- 서브쿼리 내에서 메인쿼리의 컬럼이 사용된 서브쿼리
-- 부서장직을 지냈던 경력이 있는 사원의 정보를 출력
SELECT
	emp.*
FROM employees emp
WHERE
	emp.emp_id IN (
		SELECT
			depm.emp_id
		FROM department_managers depm
		WHERE
			depm.emp_id = emp.emp_id
	)
;

SELECT
	emp.*
FROM employees emp
	JOIN department_managers depm
		ON emp.emp_id = depm.emp_id
;

-- ------------------
-- SELECT 절에서 사용
-- ------------------

-- 사원별 역대 전체 급여 평균
SELECT
	emp.emp_id
	, (
		select
			AVG(sal.salary)
		FROM salaries sal
		WHERE sal.emp_id = emp.emp_id
	) avg_sal
FROM employees emp
;

-- ------------------
-- FROM 절에서 사용
-- ------------------

SELECT
	tmp.*
FROM (
	SELECT
		emp.emp_id
		,emp.`name`
	FROM employees emp
	WHERE
		fire_at IS NULL
) tmp -- 임시라는 뜻
;

-- ------------------
-- INSERT 절에서 사용
-- ------------------

INSERT INTO employees (
	emp_id
	,`name`
	,birth
	,gender
	,hire_at
)
VALUES (
	(SELECT MAX(emp.emp_id) + 1 FROM employees emp)
	,'둘리'
	,'1980-01-01'
	,'M'
	,NOW()
);

-- ------------------
-- UPDATE 문에서 사용
-- ------------------
-- 퇴사한 사원의 퇴사일로
-- 직급 테이블의 직급 종료일도 갱신해주세요.
UPDATE title_emps
SET
	title_emps.end_at = (
		SELECT employees.fire_at
		FROM employees
		WHERE
			employees.emp_id = 100017
	)
WHERE
	title_emps.emp_id = 100017
	AND title_emps.end_at IS NULL
;