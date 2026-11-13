-- ---------------------------------
-- 테이블 개념적 설계 - 브레인스토밍
-- ---------------------------------

-- 유저 테이블
-- pk, 이메일, PW, 이름, 생년월일, 전화번호, 성별, 주소, 프로필,
-- 가입일자, 탈퇴일, 작성일, 수정일, 삭제일

-- 게시글 테이블
-- PK, 제목, 본문, 이미지, 작성자, 게시글 삭제일, 작성일, 수정일, 삭제일


-- --------------------------------------------
-- 생년월일 전체를 가져왔을 때 월만 가져오는 법
-- --------------------------------------------

-- SELECT *
-- FROM employees
-- WHERE
-- 	MONTH(birth) = MONTH(NOW())
-- ;


-- CREATE DATABASE test;
-- USE test;

-- -----------
-- 물리적 설계
-- -----------

-- 1. 테이블 생성

CREATE TABLE users (
	id 				BIGINT 			PRIMARY KEY AUTO_INCREMENT
	, email 			VARCHAR(100) 	NOT NULL
	, `password` 	VARCHAR(255) 	NOT NULL
	, user_name 	VARCHAR(30) 	NOT NULL
	, birth 			DATE 				NOT NULL
	, phone 			CHAR(13) 		NOT NULL COMMENT '\'010-XXXX-XXXX\' ,하이픈 포함 13자리'
	, gender 		CHAR(1) 			NOT NULL COMMENT '\'M\', \'F\''
	, addr_number 	CHAR(5)
	, addr1 			VARCHAR(50)
	, addr2 			VARCHAR(50)
	, `profile` 	VARCHAR(100)
	, hired_at 		DATE 				NOT NULL DEFAULT (CURRENT_DATE())
	-- (CURRENT_DATE()) → DEFAULT 표현식을 감싸는 괄호 + 함수 호출
	, withdrawn_at DATE 				DEFAULT NULL
	, created_at 	DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP()
	, updated_at 	DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP()
	, deleted_at 	DATETIME 		DEFAULT NULL
	
	-- CONSTRAINT 키워드로 이름을 별도로 지정
	, CONSTRAINT uk_users_email UNIQUE (email)
);

CREATE TABLE posts (
	id 				BIGINT 			PRIMARY KEY AUTO_INCREMENT
	, user_id		BIGINT			NOT NULL
	, title 			VARCHAR(100) 	NOT NULL
	, content	 	VARCHAR(500)
	, image		 	VARCHAR(100) 	NOT NULL
	, deactived_at DATE		posts		DEFAULT NULL
	, created_at 	DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP()
	, updated_at 	DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP()
	, deleted_at 	DATETIME 		DEFAULT NULL
	
	-- CONSTRAINT 키워드로 이름을 별도로 지정
-- 	, CONSTRAINT fk_posts_user_id FOREIGN KEY (user_id) REFERENCES users(id)
);


-- -----------
-- 테이블 수정
-- -----------

-- 컬럼에 추가
ALTER TABLE users
ADD COLUMN birth_month CHAR(2) NOT NULL COMMENT '\'MM\' 양식';

-- 컬럼 수정
ALTER TABLE users
MODIFY COLUMN birth_month CHAR(2) COMMENT '\'MM\' 양식';

-- 컬럼 삭제
ALTER TABLE users
DROP COLUMN birth_month;

-- 제약조건 (Constraint) 추가
-- posts 테이블에 FK 제약조건 추가
ALTER TABLE posts
ADD CONSTRAINT fk_posts_user_id
FOREIGN KEY (user_id) REFERENCES users(id);

-- 제약조건 (Constraint) 제거
ALTER TABLE posts
DROP CONSTRAINT fk_posts_user_id;

-- index 제거
ALTER TABLE posts
DROP INDEX fk_posts_user_id;

-- ----------------------
-- AUTO_INCREMENT 값 변경
-- ----------------------

ALTER TABLE users AUTO_INCREMENT = 1;

-- --------------------------------------------------------
-- TRUNCATE 문: 테이블의 모든 데이터를 깨끗하게 제거하는 문
-- log도 남기지않고 물리적 삭제 > 복구할 방법 X !!!!
-- ※ 오타 주의할 것.
-- --------------------------------------------------------
TRUNCATE TABLE users;


-- -----------
-- 테이블 삭제
-- -----------

DROP TABLE posts, users;

