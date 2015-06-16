--identities 表格迁移
CREATE TABLE identities (
    id integer NOT NULL,
    extern_uid character varying(255),
    provider character varying(255),
    user_id integer,
    created_at timestamp,
    updated_at timestamp
);

INSERT INTO identities (extern_uid, provider, user_id, created_at, updated_at) SELECT extern_uid, provider, id, created_at, updated_at FROM users;
