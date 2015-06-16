--删除之前创建的表格 
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
