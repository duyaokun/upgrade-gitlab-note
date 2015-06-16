-- ALTER TABLE `users` ADD `extern_uid` varchar(255) DEFAULT NULL;
-- ALTER TABLE `users` ADD `provider` varchar(255) DEFAULT NULL;
-- UPDATE users SET extern_uid=i.extern_uid provider=i.provider;
ALTER TABLE `users` DROP COLUMN `public_email`;
ALTER TABLE `users` DROP COLUMN `notification_email`;
ALTER TABLE `users` CHANGE `admin` `admin` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE `users` CHANGE `can_create_group` `can_create_group` tinyint(1) NOT NULL DEFAULT '1';
ALTER TABLE `users` CHANGE `can_create_team` `can_create_team` tinyint(1) NOT NULL DEFAULT '1';
ALTER TABLE `users` CHANGE `hide_no_ssh_key` `hide_no_ssh_key` tinyint(1) NOT NULL DEFAULT '0';

-- 删除之前创建的表格 
DROP TABLE identities;
DROP TABLE members;

-- 还原修改的字段
ALTER TABLE `notes` CHANGE `system` `system` TINYINT(1) NOT NULL DEFAULT '0';

ALTER TABLE `projects` CHANGE `issues_enabled` `issues_enabled` TINYINT(1) NOT NULL DEFAULT '1';
ALTER TABLE `projects` CHANGE `wall_enabled` `wall_enabled` TINYINT(1) NOT NULL DEFAULT '1';
ALTER TABLE `projects` CHANGE `merge_requests_enabled` `merge_requests_enabled` TINYINT(1) NOT NULL DEFAULT '1';
ALTER TABLE `projects` CHANGE `wiki_enabled` `wiki_enabled` TINYINT(1) NOT NULL DEFAULT '1';
ALTER TABLE `projects` CHANGE `snippets_enabled` `snippets_enabled` TINYINT(1) NOT NULL DEFAULT '1';
ALTER TABLE `projects` CHANGE `archived` `archived` TINYINT(1) NOT NULL DEFAULT '0';

UPDATE snippets SET visibility_level=2 WHERE visibility_level=0;
UPDATE snippets SET visibility_level=0 WHERE visibility_level=1;
UPDATE snippets SET visibility_level=1 WHERE visibility_level=2;
ALTER TABLE `snippets` CHANGE `visibility_level` `private` TINYINT(1) DEFAULT 1 NOT NULL;

ALTER TABLE `tags` DROP COLUMN `taggings_count`;
