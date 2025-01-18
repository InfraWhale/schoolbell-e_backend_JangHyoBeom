-- 테이블 생성
CREATE TABLE "users" (
	"user_id" int8 GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"name" varchar(20) NOT NULL
);

CREATE TABLE "approval" (
	"approval_id" int8 GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"title" varchar(100) NULL,
	"content" varchar(500) NULL,
	"submitted_by" int8 NOT NULL,
	"created_at" timestamp NOT NULL,
	"modified_at" timestamp NOT NULL,
	CONSTRAINT "FK_APPROVAL_SUBMITTED_BY" FOREIGN KEY ("submitted_by") REFERENCES "user" ("user_id")
);

CREATE TABLE "review_status" (
	"review_status_id" int8 GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"detail" varchar(20) NOT NULL
);

CREATE TABLE "approval_review" (
	"approval_review_id" int8 GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	"step" int4 NOT NULL,
	"comment" varchar(300) NULL,
	"approval_id" int8 NOT NULL,
	"reviewed_by" int8 NOT NULL,
	"review_status_id" int8 NOT NULL,
	"created_at" timestamp NOT NULL,
	"modified_at" timestamp NOT NULL,
	CONSTRAINT "FK_APPROVAL_REVIEW_APPROVAL_ID" FOREIGN KEY ("approval_id") REFERENCES "approval" ("approval_id"),
	CONSTRAINT "FK_APPROVAL_REVIEW_REVIEWED_BY" FOREIGN KEY ("reviewed_by") REFERENCES "user" ("user_id"),
	CONSTRAINT "FK_APPROVAL_REVIEW_STATUS_ID" FOREIGN KEY ("review_status_id") REFERENCES "review_status" ("review_status_id")
);

-- 테스트 데이터 입력
INSERT INTO 
    "users" ("name") 
VALUES
    ('권율'),
    ('이순신'),
    ('곽재우'),
    ('김시민');

INSERT INTO 
    "review_status" ("detail") 
values
    ('검토 전'),
    ('검토 중'),
    ('승인'),
    ('반려');

INSERT INTO 
    "approval" ("title", "content", "submitted_by", "created_at", "modified_at") 
VALUES
    ('출장 신청', '부산 출장을 신청합니다.', 2, NOW(), NOW()),
    ('연차 신청', '금주 금요일 연차를 사용하고 싶습니다.', 1, NOW(), NOW());

INSERT INTO 
"approval_review" ("step", "comment", "approval_id", "reviewed_by", "review_status_id", "created_at", "modified_at") 
VALUES
    (1, '출장 타당성이 검토되었습니다.', 1, 3, 3, NOW(), NOW()),
    (2, '출장 경비 신청서가 미제출되었습니다.', 1, 4, 4, NOW(), NOW()),
    (1, '연차 일정에 문제가 없습니다.', 2, 2, 3, NOW(), NOW()),
    (2, null, 2, 3, 2, NOW(), NOW()),
    (3, null, 2, 4, 1, NOW(), NOW());

-- 특정 사용자 (아래는 3번 사용자)가 처리해야 할 결재 건을 나열하는 query
SELECT
	a.approval_id, 
	a.title,
	a.content,
	u1.name AS submitted_by_name,
	ar.step,
	ar.comment,
	u2.name AS reviewed_by_name,
	rs.detail AS review_status_detail
FROM
	approval a
LEFT JOIN 
	approval_review ar 
	ON a.approval_id = ar.approval_id
LEFT JOIN 
	users u1 
	ON a.submitted_by = u1.user_id
LEFT JOIN 
	users u2 
	ON ar.reviewed_by  = u2.user_id
LEFT JOIN 
	review_status rs
    ON ar.review_status_id = rs.review_status_id
WHERE ar.reviewed_by = 3;