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

* [导入表格未发生变化的数据](same_with_7.11/README.md)

## 导入其他有变化的数据表格
### users
$ ./mysqldump --no-create-db --no-create-info --compatible=postgresql --default-character-set=utf8 -r users.sql -u bitnami bitnami_gitlab users -p
> mysqldump.exe --complete-insert --no-create-db --no-create-info --compatible=postgresql --default-character-set=utf8 -r users.sql -u root test users -p
$ python db_converter.py users.sql users.psql
$ sudo -u gitlab ./psql -d gitlabhq_production -f /home/gitlab/gitignore/mysql/users.psql

删除新版数据库
```
  id |       email       |                      encrypted_password                      | reset_password_token | reset_password_sent_at | remember_created_at | sign_in_count
 |     current_sign_in_at     |      last_sign_in_at       | current_sign_in_ip | last_sign_in_ip |         created_at         |         updated_at         |     name      
| admin | projects_limit | skype | linkedin | twitter | authentication_token | theme_id | bio | failed_attempts | locked_at | username | can_create_group | can_create_team 
| state  | color_scheme_id | notification_level | password_expires_at | created_by_id | last_credential_check_at | avatar |                        confirmation_token       
                 |        confirmed_at        |   confirmation_sent_at   |    unconfirmed_email    | hide_no_ssh_key | website_url | github_access_token | gitlab_access_tok
en |   notification_email    | hide_no_password | password_automatically_set | bitbucket_access_token | bitbucket_access_token_secret | location | public_email | encrypted_
otp_secret | encrypted_otp_secret_iv | encrypted_otp_secret_salt | otp_required_for_login | otp_backup_codes 
----+-------------------+--------------------------------------------------------------+----------------------+------------------------+---------------------+--------------
-+----------------------------+----------------------------+--------------------+-----------------+----------------------------+----------------------------+---------------
+-------+----------------+-------+----------+---------+----------------------+----------+-----+-----------------+-----------+----------+------------------+-----------------
+--------+-----------------+--------------------+---------------------+---------------+--------------------------+--------+-------------------------------------------------
-----------------+----------------------------+--------------------------+-------------------------+-----------------+-------------+---------------------+------------------
---+-------------------------+------------------+----------------------------+------------------------+-------------------------------+----------+--------------+-----------
-----------+-------------------------+---------------------------+------------------------+------------------
  1 | admin@example.com | $2a$10$gBEesx./3su/dUGq7fwHGO9BbH2Gp3GMpw5/vbOafAVID5x.pVaKa |                      |                        |                     |             3
 | 2015-06-14 07:28:50.061969 | 2015-06-12 08:58:01.181254 | 127.0.0.1          | 127.0.0.1       | 2015-06-12 06:13:02.661432 | 2015-06-14 07:28:50.091154 | Administrator 
| t     |          10000 |       |          |         | ttASR1-f_mvSFyxZbtz5 |        2 |     |               0 |           | root     | t                | f               
| active |               1 |                  1 |                     |               |                          |        | be02959a589adcacc4ac0bf982cc12881849c09900887cb6
2be9201beaea9729 | 2015-06-12 06:13:02.943674 | 2015-06-13 10:11:13.3463 | duyaokun@carystudio.com | f               |             |                     |                  
   | duyaokun@carystudio.com | f                | f                          |                        |                               |          |              |           
           |                         |                           |                        | null
(1 row)
```

### projects
$ ./mysqldump --complete-insert --no-create-db --no-create-info --compatible=postgresql --default-character-set=utf8 -r projects.sql -u bitnami bitnami_gitlab projects -p
> mysqldump.exe --complete-insert --no-create-db --no-create-info --compatible=postgresql --default-character-set=utf8 -r projects.sql -u root test projects -p
$ python db_converter.py projects.sql projects.psql
$ sudo -u gitlab ./psql -d gitlabhq_production -f /home/gitlab/gitignore/mysql/projects.psql

### protected_branches
$ ./mysqldump --complete-insert --no-create-db --no-create-info --compatible=postgresql --default-character-set=utf8 -r protected_branches.sql -u bitnami bitnami_gitlab protected_branches -p
$ python db_converter.py protected_branches.sql protected_branches.psql
$ sudo -u gitlab ./psql -d gitlabhq_production -f /home/gitlab/gitignore/mysql/protected_branches.psql

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


### snippets
$ ./mysqldump --complete-insert --no-create-db --no-create-info --compatible=postgresql --default-character-set=utf8 -r snippets.sql -u bitnami bitnami_gitlab snippets -p
> ALTER TABLE `snippets` DROP `private`;
> ALTER TABLE `snippets` ADD `visibility_level` INT NOT NULL DEFAULT '0' ;
> mysqldump.exe --complete-insert --no-create-db --no-create-info --compatible=postgresql --default-character-set=utf8 -r snippets.sql -u root test snippets -p
$ python db_converter.py snippets.sql snippets.psql
$ sudo -u gitlab ./psql -d gitlabhq_production -f /home/gitlab/gitignore/mysql/snippets.psql

### tags
$ ./mysqldump --complete-insert --no-create-db --no-create-info --compatible=postgresql --default-character-set=utf8 -r tags.sql -u bitnami bitnami_gitlab tags -p
$ python db_converter.py tags.sql tags.psql
$ sudo -u gitlab ./psql -d gitlabhq_production -f /home/gitlab/gitignore/mysql/tags.psql

### notes
$ ALTER TABLE `notes` CHANGE `system` `system` CHAR(1) NOT NULL DEFAULT '0';
$ ./mysqldump --complete-insert --no-create-db --no-create-info --compatible=postgresql --default-character-set=utf8 -r notes.sql -u bitnami bitnami_gitlab notes -p
$ ALTER TABLE `notes` CHANGE `system` `system` TINYINT(1) NOT NULL DEFAULT '0';
$ python db_converter.py notes.sql notes.psql
$ sudo -u gitlab ./psql -d gitlabhq_production -f /home/gitlab/gitignore/mysql/notes.psql

## merge_requests
$ ./mysqldump --complete-insert --no-create-db --no-create-info --compatible=postgresql --default-character-set=utf8 -r merge_requests.sql -u bitnami bitnami_gitlab merge_requests -p
$ python db_converter.py merge_requests.sql merge_requests.psql
$ sudo -u gitlab ./psql -d gitlabhq_production -f /home/gitlab/gitignore/mysql/merge_requests.psql
