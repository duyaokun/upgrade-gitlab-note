--删除之前创建的表格 
DROP TABLE identities;
DROP TABLE members;

-- 还原修改的字段
ALTER TABLE `notes` CHANGE `system` `system` TINYINT(1) NOT NULL DEFAULT '0';
