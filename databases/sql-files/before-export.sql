-- identities 表格迁移
CREATE TABLE identities (
    id integer NOT NULL,
    extern_uid character varying(255),
    provider character varying(255),
    user_id integer,
    created_at timestamp,
    updated_at timestamp
);

INSERT INTO identities (extern_uid, provider, user_id, created_at, updated_at) SELECT extern_uid, provider, id, created_at, updated_at FROM users;

-- members 表格迁移
CREATE TABLE members (
    id integer KEY NOT NULL AUTO_INCREMENT,
    access_level integer NOT NULL,
    source_id integer NOT NULL,
    source_type character varying(255) NOT NULL,
    user_id integer,
    notification_level integer NOT NULL,
    type character varying(255),
    created_at timestamp,
    updated_at timestamp,
    created_by_id integer,
    invite_email character varying(255),
    invite_token character varying(255),
    invite_accepted_at timestamp
);

INSERT INTO members ( user_id, source_id, source_type, access_level, notification_level, type ) SELECT user_id, group_id, 'Namespace', group_access, notification_level, 'GroupMember' FROM users_groups;

INSERT INTO members ( user_id, source_id, source_type, access_level, notification_level, type ) SELECT user_id, project_id, 'Project', project_access, notification_level, 'ProjectMember' FROM users_projects;

-- notes 表格迁移
ALTER TABLE `notes` CHANGE `system` `system` CHAR(1) NOT NULL DEFAULT '0';

-- projects 表格迁移
ALTER TABLE `projects` CHANGE `issues_enabled` `issues_enabled` CHAR(1) NOT NULL DEFAULT '1';
ALTER TABLE `projects` CHANGE `wall_enabled` `wall_enabled` CHAR(1) NOT NULL DEFAULT '1';
ALTER TABLE `projects` CHANGE `merge_requests_enabled` `merge_requests_enabled` CHAR(1) NOT NULL DEFAULT '1';
ALTER TABLE `projects` CHANGE `wiki_enabled` `wiki_enabled` CHAR(1) NOT NULL DEFAULT '1';
ALTER TABLE `projects` CHANGE `snippets_enabled` `snippets_enabled` CHAR(1) NOT NULL DEFAULT '1';
ALTER TABLE `projects` CHANGE `archived` `archived` CHAR(1) NOT NULL DEFAULT '0';

-- snippets 表格迁移
ALTER TABLE `snippets` CHANGE `private` `visibility_level` INTEGER DEFAULT 0 NOT NULL;
UPDATE snippets SET visibility_level=2 WHERE visibility_level=0;
UPDATE snippets SET visibility_level=0 WHERE visibility_level=1;
UPDATE snippets SET visibility_level=1 WHERE visibility_level=2;

-- tags 表格迁移
ALTER TABLE `tags` ADD `taggings_count` INTEGER DEFAULT 0 NOT NULL;
UPDATE tags SET taggings_count=(SELECT COUNT(1) FROM taggings WHERE taggings.tag_id=tags.id);

-- users 表格迁移
ALTER TABLE `users` ADD `notification_email` character varying(255);
ALTER TABLE `users` ADD `public_email` character varying(255);
UPDATE users SET public_email=email, notification_email=email;
-- 注意: 必须迁移 identities 才可以执行下面这个操作
-- ALTER TABLE `users` DROP COLUMN `extern_uid`;
-- ALTER TABLE `users` DROP COLUMN `provider`;
