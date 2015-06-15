-- MySQL dump 10.13  Distrib 5.5.36, for linux2.6 (i686)
--
-- Host: localhost    Database: bitnami_gitlab
-- ------------------------------------------------------
-- Server version	5.5.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES UTF8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `broadcast_messages`
--

DROP TABLE IF EXISTS `broadcast_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `broadcast_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `alert_type` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `font` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deploy_keys_projects`
--

DROP TABLE IF EXISTS `deploy_keys_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deploy_keys_projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deploy_key_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_deploy_keys_projects_on_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emails`
--

DROP TABLE IF EXISTS `emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_emails_on_email` (`email`) USING BTREE,
  KEY `index_emails_on_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_type` varchar(255) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `data` text,
  `project_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `action` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_events_on_action` (`action`) USING BTREE,
  KEY `index_events_on_author_id` (`author_id`) USING BTREE,
  KEY `index_events_on_created_at` (`created_at`) USING BTREE,
  KEY `index_events_on_project_id` (`project_id`) USING BTREE,
  KEY `index_events_on_target_id` (`target_id`) USING BTREE,
  KEY `index_events_on_target_type` (`target_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23533 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forked_project_links`
--

DROP TABLE IF EXISTS `forked_project_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forked_project_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forked_to_project_id` int(11) NOT NULL,
  `forked_from_project_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_forked_project_links_on_forked_to_project_id` (`forked_to_project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `issues`
--

DROP TABLE IF EXISTS `issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `assignee_id` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `position` int(11) DEFAULT '0',
  `branch_name` varchar(255) DEFAULT NULL,
  `description` text,
  `milestone_id` int(11) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `iid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_issues_on_project_id_and_iid` (`project_id`,`iid`) USING BTREE,
  KEY `index_issues_on_assignee_id` (`assignee_id`) USING BTREE,
  KEY `index_issues_on_author_id` (`author_id`) USING BTREE,
  KEY `index_issues_on_created_at` (`created_at`) USING BTREE,
  KEY `index_issues_on_milestone_id` (`milestone_id`) USING BTREE,
  KEY `index_issues_on_project_id` (`project_id`) USING BTREE,
  KEY `index_issues_on_title` (`title`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1676 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `keys`
--

DROP TABLE IF EXISTS `keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `key` text,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `fingerprint` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_keys_on_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_request_diffs`
--

DROP TABLE IF EXISTS `merge_request_diffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merge_request_diffs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(255) DEFAULT NULL,
  `st_commits` longtext,
  `st_diffs` longtext,
  `merge_request_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_merge_request_diffs_on_merge_request_id` (`merge_request_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2353 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_requests`
--

DROP TABLE IF EXISTS `merge_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merge_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_branch` varchar(255) NOT NULL,
  `source_branch` varchar(255) NOT NULL,
  `source_project_id` int(11) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `assignee_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `milestone_id` int(11) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `merge_status` varchar(255) DEFAULT NULL,
  `target_project_id` int(11) NOT NULL,
  `iid` int(11) DEFAULT NULL,
  `description` text,
  `position` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_merge_requests_on_target_project_id_and_iid` (`target_project_id`,`iid`) USING BTREE,
  KEY `index_merge_requests_on_assignee_id` (`assignee_id`) USING BTREE,
  KEY `index_merge_requests_on_author_id` (`author_id`) USING BTREE,
  KEY `index_merge_requests_on_created_at` (`created_at`) USING BTREE,
  KEY `index_merge_requests_on_milestone_id` (`milestone_id`) USING BTREE,
  KEY `index_merge_requests_on_source_branch` (`source_branch`) USING BTREE,
  KEY `index_merge_requests_on_source_project_id` (`source_project_id`) USING BTREE,
  KEY `index_merge_requests_on_target_branch` (`target_branch`) USING BTREE,
  KEY `index_merge_requests_on_title` (`title`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2353 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `milestones`
--

DROP TABLE IF EXISTS `milestones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `milestones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `project_id` int(11) NOT NULL,
  `description` text,
  `due_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `iid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_milestones_on_project_id_and_iid` (`project_id`,`iid`) USING BTREE,
  KEY `index_milestones_on_due_date` (`due_date`) USING BTREE,
  KEY `index_milestones_on_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `namespaces`
--

DROP TABLE IF EXISTS `namespaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `namespaces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `avatar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_namespaces_on_name` (`name`) USING BTREE,
  KEY `index_namespaces_on_owner_id` (`owner_id`) USING BTREE,
  KEY `index_namespaces_on_path` (`path`) USING BTREE,
  KEY `index_namespaces_on_type` (`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `note` text,
  `noteable_type` varchar(255) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `line_code` varchar(255) DEFAULT NULL,
  `commit_id` varchar(255) DEFAULT NULL,
  `noteable_id` int(11) DEFAULT NULL,
  `system` tinyint(1) NOT NULL DEFAULT '0',
  `st_diff` longtext,
  PRIMARY KEY (`id`),
  KEY `index_notes_on_author_id` (`author_id`) USING BTREE,
  KEY `index_notes_on_commit_id` (`commit_id`) USING BTREE,
  KEY `index_notes_on_created_at` (`created_at`) USING BTREE,
  KEY `index_notes_on_noteable_id_and_noteable_type` (`noteable_id`,`noteable_type`) USING BTREE,
  KEY `index_notes_on_noteable_type` (`noteable_type`) USING BTREE,
  KEY `index_notes_on_project_id_and_noteable_type` (`project_id`,`noteable_type`) USING BTREE,
  KEY `index_notes_on_project_id` (`project_id`) USING BTREE,
  KEY `index_notes_on_updated_at` (`updated_at`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10540 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `description` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `issues_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `wall_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `merge_requests_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `wiki_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `namespace_id` int(11) DEFAULT NULL,
  `issues_tracker` varchar(255) NOT NULL DEFAULT 'gitlab',
  `issues_tracker_id` varchar(255) DEFAULT NULL,
  `snippets_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `last_activity_at` datetime DEFAULT NULL,
  `import_url` varchar(255) DEFAULT NULL,
  `visibility_level` int(11) NOT NULL DEFAULT '0',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `import_status` varchar(255) DEFAULT NULL,
  `repository_size` float DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_projects_on_creator_id` (`creator_id`) USING BTREE,
  KEY `index_projects_on_last_activity_at` (`last_activity_at`) USING BTREE,
  KEY `index_projects_on_namespace_id` (`namespace_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `protected_branches`
--

DROP TABLE IF EXISTS `protected_branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `protected_branches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_protected_branches_on_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=349 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `project_url` varchar(255) DEFAULT NULL,
  `subdomain` varchar(255) DEFAULT NULL,
  `room` varchar(255) DEFAULT NULL,
  `recipients` text,
  `api_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_services_on_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=316 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `snippets`
--

DROP TABLE IF EXISTS `snippets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snippets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` longtext,
  `author_id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `private` tinyint(1) NOT NULL DEFAULT '1',
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_snippets_on_author_id` (`author_id`) USING BTREE,
  KEY `index_snippets_on_created_at` (`created_at`) USING BTREE,
  KEY `index_snippets_on_expires_at` (`expires_at`) USING BTREE,
  KEY `index_snippets_on_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggings`
--

DROP TABLE IF EXISTS `taggings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) DEFAULT NULL,
  `taggable_id` int(11) DEFAULT NULL,
  `taggable_type` varchar(255) DEFAULT NULL,
  `tagger_id` int(11) DEFAULT NULL,
  `tagger_type` varchar(255) DEFAULT NULL,
  `context` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_taggings_on_tag_id` (`tag_id`) USING BTREE,
  KEY `index_taggings_on_taggable_id_and_taggable_type_and_context` (`taggable_id`,`taggable_type`,`context`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2620 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `projects_limit` int(11) DEFAULT '10',
  `skype` varchar(255) NOT NULL DEFAULT '',
  `linkedin` varchar(255) NOT NULL DEFAULT '',
  `twitter` varchar(255) NOT NULL DEFAULT '',
  `authentication_token` varchar(255) DEFAULT NULL,
  `theme_id` int(11) NOT NULL DEFAULT '1',
  `bio` varchar(255) DEFAULT NULL,
  `failed_attempts` int(11) DEFAULT '0',
  `locked_at` datetime DEFAULT NULL,
  `extern_uid` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `can_create_group` tinyint(1) NOT NULL DEFAULT '1',
  `can_create_team` tinyint(1) NOT NULL DEFAULT '1',
  `state` varchar(255) DEFAULT NULL,
  `color_scheme_id` int(11) NOT NULL DEFAULT '1',
  `notification_level` int(11) NOT NULL DEFAULT '1',
  `password_expires_at` datetime DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) DEFAULT NULL,
  `hide_no_ssh_key` tinyint(1) DEFAULT '0',
  `website_url` varchar(255) NOT NULL DEFAULT '',
  `last_credential_check_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`) USING BTREE,
  UNIQUE KEY `index_users_on_authentication_token` (`authentication_token`) USING BTREE,
  UNIQUE KEY `index_users_on_confirmation_token` (`confirmation_token`) USING BTREE,
  UNIQUE KEY `index_users_on_extern_uid_and_provider` (`extern_uid`,`provider`) USING BTREE,
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`) USING BTREE,
  KEY `index_users_on_admin` (`admin`) USING BTREE,
  KEY `index_users_on_current_sign_in_at` (`current_sign_in_at`) USING BTREE,
  KEY `index_users_on_name` (`name`) USING BTREE,
  KEY `index_users_on_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_access` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `notification_level` int(11) NOT NULL DEFAULT '3',
  PRIMARY KEY (`id`),
  KEY `index_users_groups_on_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_projects`
--

DROP TABLE IF EXISTS `users_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `project_access` int(11) NOT NULL DEFAULT '0',
  `notification_level` int(11) NOT NULL DEFAULT '3',
  PRIMARY KEY (`id`),
  KEY `index_users_projects_on_project_access` (`project_access`) USING BTREE,
  KEY `index_users_projects_on_project_id` (`project_id`) USING BTREE,
  KEY `index_users_projects_on_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=191 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_hooks`
--

DROP TABLE IF EXISTS `web_hooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_hooks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT 'ProjectHook',
  `service_id` int(11) DEFAULT NULL,
  `push_events` tinyint(1) NOT NULL DEFAULT '1',
  `issues_events` tinyint(1) NOT NULL DEFAULT '0',
  `merge_requests_events` tinyint(1) NOT NULL DEFAULT '0',
  `tag_push_events` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_web_hooks_on_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-06-13 16:58:53
