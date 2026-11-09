-- DELETE 문
-- DML 중 하나로 저장되어 있는
-- 기존 데이터를 삭제하기 위해 사용하는 쿼리
-- 복구방법이 없기 때문에 조심해서 사용해야한다

-- DELETE FROM 테이블명
-- [WHERE 조건];
DELETE FROM title_emps
-- FROM 절 부터 적지말 것 > 조건이 없을 경우 전체가 삭제될 수 있다.
WHERE
	start_at >= '2026-11-09'
;
SELECT * FROM title_emps WHERE start_at >= '2026-11-09';