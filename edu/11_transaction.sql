-- -----------
-- TRANSACTION
-- -----------

-- Transaction 시작
START TRANSACTION;

-- 이후 여러 연산 처리
INSERT INTO employees(
	`name`
	,birth
	,gender
	,hire_at
)
VALUES(
	'미어캣'
	,'1990-02-23'
	,'M'
	,NOW()
);

-- 정상 완료면 COMMIT으로 연산결과 저장
-- 비정상 처리가 있다면 ROLLBACK으로 연산 이전의 상태로 회귀
COMMIT;
ROLLBACK;