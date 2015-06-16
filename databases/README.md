# GitLab 7.1.0 bitnami to GitLab 7.11.4 Omnibus

## Mysql To PostgreSQL
[7.1 旧数据库结构](gitlab.7.1.sql)
[7.11 原始数据库](gitlab.7.11.psql)

数据库差异如下:

|7.11.0                 |7.1.0
|-----------------------|------
|application_settings   | no
|>identities            | from {users.extern_uid, users.provider}
|>keys                  | no [public]
|label_links            | no
|labels                 | no
|^members               | no
|^merge_requests        | no [locked_at]
|^notes [system(boolean)] | notes [system(tinyint)]
|oauth_access_grants    | no
|oauth_access_tokens    | no
|oauth_applications     | no
|project_import_data    | no
|^projects              | no [avatar, star_count, import_type, import_source]
|^protected_branches    | no [developers_can_push]
|^services no [token, project_url, subdomain, room, recipients, api_key] | no [properties, template, push_events, issues_events, merge_requests_events, tag_push_events, note_events]
|^snippets no [private] | no [visibility_level]
|subscriptions          | no
|^tags                  | no [taggings_count]
|^users no [extern_uid, provider] | no [github_access_token, gitlab_access_token,notification_email, hide_no_password, password_automatically_set, bitbucket_access_token, bitbucket_access_token_secret, location character, public_email, encrypted_otp_secret, encrypted_otp_secret_iv, encrypted_otp_secret_salt, otp_required_for_login, otp_backup_codes]
|users_star_projects    | no
|no {to identities}     | users_groups
|no {to identities}     | users_projects

1. 在旧服务数据中执行 SQL 脚本 `before-export.psql`
2. 在旧服务器运行脚本`./upgrade.sh`
3. 在旧服务数据中执行 SQL 脚本 `after-export.psql`
4. 将导出的数据库压缩包下载至本地,用数据库管理工具(如 phpmyadmin )删除 `extern_uid` 和 `provider` 两列,然后导出转成 *psql* 格式

	> mysqldump.exe --complete-insert --no-create-db --no-create-info --compatible=postgresql --default-character-set=utf8 -r users.sql -u root test users -p
5. 将转换好的 psql 数据库上传至新服务器
6. 在新服务数据中执行 SQL 脚本 `before-import.psql`
7. 在新服务器运行脚本`./upgrade-same-schema-tables.sh import`
8. 在新服务数据中执行 SQL 脚本 `after-import.psql`

## 导入其他有变化的数据表格

### services
$ ./mysqldump --complete-insert --no-create-db --no-create-info --compatible=postgresql --default-character-set=utf8 -r services.sql -u bitnami bitnami_gitlab services -p
> ALTER TABLE `services` DROP `token`, DROP `project_url`, DROP `subdomain`, DROP `room`, DROP `recipients`, DROP `api_key`;
> ALTER TABLE `services` CHANGE `active` `active` CHAR(1) NOT NULL DEFAULT '0'; 
> mysqldump.exe --complete-insert --no-create-db --no-create-info --compatible=postgresql --default-character-set=utf8 -r services.sql -u root test services -p
$ python db_converter.py services.sql services.psql
> delete from services;

```
gitlabhq_production=> select * from services;
 id |           type            | title | project_id |         created_at         |         updated_at         | active | properties | template | push_events | issues_event
s | merge_requests_events | tag_push_events | note_events 
----+---------------------------+-------+------------+----------------------------+----------------------------+--------+------------+----------+-------------+-------------
--+-----------------------+-----------------+-------------
  1 | GitlabIssueTrackerService |       |        192 | 2015-06-14 08:55:08.191286 | 2015-06-14 08:55:08.191286 | f      | {}         | f        | t           | t           
  | t                     | t               | t
  2 | GitlabIssueTrackerService |       |         37 | 2015-06-14 09:01:59.511754 | 2015-06-14 09:01:59.511754 | f      | {}         | f        | t           | t           
  | t                     | t               | t
  3 | GitlabIssueTrackerService |       |        117 | 2015-06-14 09:02:22.914573 | 2015-06-14 09:02:22.914573 | f      | {}         | f        | t           | t           
  | t                     | t               | t
  4 | GitlabIssueTrackerService |       |         60 | 2015-06-14 09:44:42.540486 | 2015-06-14 09:44:42.540486 | f      | {}         | f        | t           | t           
  | t                     | t               | t
  5 | GitlabIssueTrackerService |       |        126 | 2015-06-14 10:11:22.181405 | 2015-06-14 10:11:22.181405 | f      | {}         | f        | t           | t           
  | t                     | t               | t
  6 | GitlabIssueTrackerService |       |         15 | 2015-06-14 11:06:32.036012 | 2015-06-14 11:06:32.036012 | f      | {}         | f        | t           | t           
  | t                     | t               | t
  7 | GitlabIssueTrackerService |       |         92 | 2015-06-14 11:06:56.144396 | 2015-06-14 11:06:56.144396 | f      | {}         | f        | t           | t           
  | t                     | t               | t
  8 | GitlabIssueTrackerService |       |        190 | 2015-06-14 11:10:46.615959 | 2015-06-14 11:10:46.615959 | f      | {}         | f        | t           | t           
  | t                     | t               | t
  9 | GitlabIssueTrackerService |       |        104 | 2015-06-14 11:11:53.950179 | 2015-06-14 11:11:53.950179 | f      | {}         | f        | t           | t           
  | t                     | t               | t
 10 | GitlabIssueTrackerService |       |        161 | 2015-06-14 11:25:21.610312 | 2015-06-14 11:25:21.610312 | f      | {}         | f        | t           | t           
  | t                     | t               | t
 11 | GitlabIssueTrackerService |       |        118 | 2015-06-14 11:52:25.479004 | 2015-06-14 11:52:25.479004 | f      | {}         | f        | t           | t           
  | t                     | t               | t
 12 | GitlabIssueTrackerService |       |        173 | 2015-06-14 12:05:29.736477 | 2015-06-14 12:05:29.736477 | f      | {}         | f        | t           | t           
  | t                     | t               | t
(12 rows)
```

$ sudo -u gitlab ./psql -d gitlabhq_production -f /home/gitlab/gitignore/mysql/services.psql