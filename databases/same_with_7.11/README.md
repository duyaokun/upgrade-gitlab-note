## 导出相同数据结构的数据表格
1. 在旧服务器运行脚本`./upgrade-same-schema-tables.sh`
2. 在新服务数据中执行 SQL 脚本 `before-import.psql`
3. 在新服务器运行脚本`./upgrade-same-schema-tables.sh import`
4. 在新服务数据中执行 SQL 脚本 `after-import.psql`
