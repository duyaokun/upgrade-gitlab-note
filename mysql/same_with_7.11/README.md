## 导出相同数据结构的数据表格

$ ./mysqldump --no-create-db --no-create-info --compatible=postgresql --default-character-set=utf8 -r same.sql -u bitnami bitnami_gitlab events forked_project_links issues merge_request_diffs milestones namespaces taggings -p
$ 6645a79e86
## MySql to PSQL
python ../db_converter.py same.sql same.psql
## 导入相同数据结构的 PSQL
$ sudo -u gitlab ./psql -d gitlabhq_production -f /home/gitlab/gitignore/mysql/same_with_7.11/same.psql

删除新版数据库 namespaces 中的数据一行(共一行)
```
 id | name | path | owner_id |         created_at         |         updated_at     
    | type | description | avatar 
----+------+------+----------+----------------------------+------------------------
----+------+-------------+--------
  1 | root | root |        1 | 2015-06-12 06:13:02.934907 | 2015-06-12 06:13:02.934
907 |      |             | 
(1 row)
```