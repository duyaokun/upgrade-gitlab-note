#!/bin/bash
#导出数据表格
mysql_password="6645a79e86"
table_name=$1

/opt/gitlab-6.9.2-1/mysql/bin/mysqldump --no-create-db --no-create-info --compatible=postgresql --default-character-set=utf8 -r ${table_name}.sql -u bitnami bitnami_gitlab ${table_name} -p${mysql_password}
