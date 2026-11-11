-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,tmp.title_code
FROM employees emp
	JOIN title_emps tmp
		ON emp.emp_id = tmp.emp_id
			AND emp.fire_at IS NULL
			AND tmp.end_at IS null
;

-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	, emp.gender
	, sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND emp.fire_at IS null
			AND sal.end_at IS NULL
;

-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
SELECT
	emp.`name`
	,sal.salary
	,sal.start_at
	,sal.end_at
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND emp.emp_id = 10010
;

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,dep.dept_name
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
			AND emp.fire_at IS NULL
	JOIN departments dep
		ON depe.dept_code = dep.dept_code
			AND depe.end_at IS NULL
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	, emp.`name`
	, sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND emp.fire_at IS NULL
			AND sal.end_at IS NULL
ORDER BY sal.salary DESC
LIMIT 10
;
-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT
	dep.dept_name
	, emp.`name`
	, emp.hire_at
FROM employees emp
	JOIN department_managers depm
		ON emp.emp_id = depm.emp_id
			AND depm.end_at IS NULL
			AND emp.fire_at IS NULL
	JOIN departments dep
		ON depm.dept_code = dep.dept_code	
;

-- 7. 현재 직급이 "부장"인 사원들의 각각의 연봉 평균을 출력해 주세요.
SELECT
	tite.emp_id
	,AVG(sal.salary)
FROM title_emps tite
	JOIN titles tit
		ON tite.title_code = tit.title_code
			AND tit.title = '부장'
			AND tite.end_at IS NULL
	JOIN salaries sal
		ON tite.emp_id = sal.emp_id
GROUP BY tite.emp_id
;

-- 7-1. (보너스)현재 각 부장별 이름, 연봉평균
SELECT
	emp.`name`
	,AVG(salary) sal_avg
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
			AND tie.end_at IS NULL
			AND emp.fire_at IS NULL
	JOIN titles tit
		ON tie.title_code = tit.title_code
			AND tit.title = '부장'
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
GROUP BY emp.emp_id
;

-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
SELECT
	emp.`name`
	, emp.hire_at
	, emp.emp_id
	, depm.dept_code
FROM employees emp
	JOIN department_managers depm
		ON emp.emp_id = depm.emp_id
			AND emp.fire_at IS null
;		

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을 평균연봉 내림차순으로 출력해 주세요.

SELECT
	tit.title
	,tite.title_code
	, CEIL(AVG(sal.salary)) avg_sal
FROM title_emps tite
	JOIN titles tit
		ON tite.title_code = tit.title_code
	JOIN salaries sal
		ON sal.emp_id = tite.emp_id
			AND sal.end_at IS NULL
			AND tite.end_at IS NULL
GROUP BY tite.title_code, tit.title
	HAVING AVG(sal.salary) >= 60000000
ORDER BY avg_sal DESC
;

-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT
	tie.title_code
	,tit.title
	,COUNT(emp.emp_id) emp_count
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
			AND emp.gender = 'F'
			AND emp.fire_at IS NULL
			AND tie.end_at IS NULL
	JOIN titles tit
		ON tit.title_code = tie.title_code
GROUP BY tie.title_code
ORDER BY tie.title_code
;

-- 전체 평균 급여보다 높은 급여를 받는 사원의 사번, 이름, 현재급여를 조회
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND emp.fire_at IS NULL
			AND sal.end_at IS null
			AND AVG(sal.salary) < sal.salary
;			

-- 가장 높은 급여를 받은 이력이있는 사원의 사번과 급여를 조회