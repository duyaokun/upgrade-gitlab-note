## 导出相同数据结构的数据表格
1. 在旧服务器运行脚本`./upgrade-same-schema-tables.sh`
2. 删除新版数据库 namespaces 中的数据一行(共一行)

  ```
 id | name | path | owner_id |         created_at         |         updated_at         | type | description | avatar 
----+------+------+----------+----------------------------+----------------------------+------+-------------+--------
  1 | root | root |        1 | 2015-06-12 06:13:02.934907 | 2015-06-12 06:13:02.934907 |      |             | 
(1 row)
  ```
3. 在新服务器运行脚本`./upgrade-same-schema-tables.sh import`
