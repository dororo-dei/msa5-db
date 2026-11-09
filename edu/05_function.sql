-- 내장 함수 (Function)

-- ---------------------
-- 데이터 타입 변환 함수
-- ---------------------

SELECT
	1234
	,CAST(1234 AS CHAR(6))
	, CONVERT(1234, CHAR(6))
;

SELECT
	CONVERT(emp_id, CHAR(20))
FROM employees
WHERE emp_id = 100005
;

-- --------------
-- 제어 흐름 함수
-- --------------

-- IF(수식, 참일 경우의 값, 거짓일 경우의 값)
SELECT
	`name`
	, gender
	, IF(gender = 'M', '남자', '여자') ko_gender
FROM employees
;

-- IFNULL(수식1, 수식2)
-- 수식1이 null이면 수식 2를 반환, 아니면 수식 1을 반환
SELECT 
	IFNULL(fire_at, '재직중') fire_state
	, fire_at
FROM employees
;

-- NULLIF(수식1, 수식2)
-- 수식1과 수식2를 비교해서 같으면 NULL을 반환
-- 다르면 수식1을 반환
SELECT
	NULLIF(gender, 'M')
FROM employees
;

-- CASE ~ WHEN ~ ELSE ~ END
-- gender가 'M'이면 '남자' 'F'이면 '여자' 아니면 '기타'로 출력
SELECT
	CASE gender
		WHEN 'M' THEN '남자'
		WHEN 'F' THEN '여자'
		ELSE '기타'
	END ko_gender
FROM employees
;


-- ------------
-- 문자열 함수
-- ------------

SELECT CONCAT('안녕','','하세요.');
SELECT CONCAT(`name`, ' ',gender) FROM employees;

-- 구분자로 문자열을 연결
SELECT CONCAT_WS(', ', '자바', 'JS', 'HTML');

-- 숫자에 자릿수(,) 및 소수점 자리수 표시
-- 0: 소수점 이하 0자리까지 표시 (정수 형태)
-- 1: 소수점 이하 1자리까지 표시
-- 2: 소수점 이하 2자리까지 표시
SELECT FORMAT(salary, 0) FROM salaries;

-- 문자열의 왼쪽/오른쪽 부터 길이만큼 잘라 반환
SELECT
	LEFT('123456', 2)
	, RIGHT('123546', 2)
;

-- 문자열의 좌/우에 문자열 길이만큼 채울 문자열을 삽입
SELECT LPAD('123', 6, '0'), RPAD('123', 6, '0');

-- 문자열의 좌/우 공백을 제거
SELECT
	'   test'
	, TRIM('   test')
	, LTRIM('   test')
	, RTRIM('   test')
;

-- 'cdefgab'
SELECT TRIM(LEADING 'ab' FROM 'abcdefgab');
-- 'cdefg'
SELECT TRIM(BOTH 'ab' FROM 'abcdefgab');
-- 'abcdefg'
SELECT TRIM(TRAILING 'ab' FROM 'abcdefgab');
	

-- 문자열을 시작위치에서 길이만큼 잘라서 반환
SELECT SUBSTRING('123456', 3, 2);

-- 왼쪽부터 구분자가 n번째 만큼 나오면 그 이후를 버림
SELECT SUBSTRING_INDEX(
	'abc_test_123.txt'
	, '.'
	, -1
) txt;

-- 영어 대/소문자 변경
SELECT UPPER('asdASDFAE'), LOWER('asdASDFAE');

-- ------------
-- 수학 함수
-- ------------

-- 올림, 반올림, 버림
SELECT CEILING(3.14), ROUND(3.14), FLOOR(3.14);

-- 절대값
SELECT ABS(-1), ABS(1);

-- 소수점을 기준으로 특정 자리수까지 구하고 나머지는 버림
SELECT TRUNCATE(1.19, 0);

-- ------------
-- 날짜 및 시간관련 함수
-- ------------

-- 현재 날짜 및 시간 변환 (YYYY-MM-DD hh:mi:ss)
SELECT NOW();

-- (YYYY-MM-DD)
-- 문자열로 써도 시분초 잘라낸다
SELECT DATE(NOW());
SELECT DATE(created_at) FROM employees;

-- 날짜의 단위기간에 따라 더한 날짜/ 시간을 반환
SELECT ADDDATE(NOW(), INTERVAL 1 YEAR);
SELECT ADDDATE(NOW(), INTERVAL -1 YEAR);
SELECT ADDDATE(NOW(), INTERVAL 1 MONTH);
SELECT ADDDATE(NOW(), INTERVAL 1 DAY);
SELECT ADDDATE(NOW(), INTERVAL 1 HOUR);
SELECT ADDDATE(NOW(), INTERVAL 1 MINUTE);
SELECT ADDDATE(NOW(), INTERVAL 1 SECOND);
SELECT ADDDATE(NOW(), INTERVAL 1 MICROSECOND);

SELECT ADDTIME(NOW(), '01:00:00');


-- ------------
-- 집계 함수
-- ------------

-- 26.11.06에 했음

-- ------------
-- 순차 함수
-- ------------
-- RANK() OVER(ORDER BY 컬럼 ASC/DESC)
-- 지정한 컬럼을 기준으로 순위를 매겨 반환
-- 동일한 값이 있는 경우 동일한 순위를 부여

SELECT
	emp_id
	, salary
	, RANK() OVER(ORDER BY salary DESC) `rank`
FROM salaries
WHERE
	end_at IS NULL
;

UPDATE salaries
SET salary = 196357546
WHERE emp_id = 93611 AND end_at IS NULL;
-- 해당 직원의 전체 급여 기록 조회
SELECT * FROM salaries WHERE emp_id = 93611;

-- ROW_NUMBER() OVER(ORDER BY salary DESC)
-- 레코드에 순위를 매겨 반환
-- 동일한 값이 있는 경우에도 각 행에 고유한 번호를 부여

SELECT 
	emp_id
	, salary
	, ROW_NUMBER() OVER(ORDER BY salary DESC) `rank`
FROM salaries
WHERE
	end_at IS NULL
;

SELECT
    emp_id
    , salary
    , DENSE_RANK() OVER(ORDER BY salary DESC) `rank`
FROM salaries
WHERE
    end_at IS NULL
;