-- VIEW 생성

CREATE VIEW view_avg_salary_by_dept
AS
	-- 부서별 현재 연봉 평균
	-- 부서코드, 부서명, 평균 연봉 출력
	SELECT
		dep.dept_code
		, dep.dept_name
		,CEIL(AVG(sal.salary))
	FROM department_emps depe
		JOIN departments dep
			ON depe.dept_code = dep.dept_code
				AND depe.end_at IS NULL
		JOIN salaries sal
			ON sal.emp_id = depe.emp_id
				AND sal.end_at IS NULL
	GROUP BY dep.dept_code, dep.dept_code
	ORDER BY dep.dept_code
;

-- emp 포함하고 연결했을 때
SELECT
	dep.dept_code
	, dep.dept_name
	, ceil(AVG(sal.salary))
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
			AND emp.fire_at IS NULL
			AND depe.end_at IS NULL
	JOIN departments dep
		ON depe.dept_code = dep.dept_code
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
GROUP BY dep.dept_code , dep.dept_name
ORDER BY dept_code
;

-- view 조회
SELECT
	*
FROM view_avg_salary_by_dept
;

-- view 삭제
DROP VIEW view_avg_salary_by_dept;

-- emp 제외하고 연결했을 때
SELECT
	dep.dept_code
	, dep.dept_name
	,CEIL(AVG(sal.salary))
FROM department_emps depe
	JOIN departments dep
		ON depe.dept_code = dep.dept_code
			AND depe.end_at IS NULL
	JOIN salaries sal
		ON sal.emp_id = depe.emp_id
			AND sal.end_at IS NULL
GROUP BY dep.dept_code , dep.dept_code
ORDER BY dep.dept_code
;
