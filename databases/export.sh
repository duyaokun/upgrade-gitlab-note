#!/bin/bash
mysql_password="6645a79e86"
table=$1

#导出 MySQL表格
echo "start export table ${table}"
/opt/gitlab-6.9.2-1/mysql/bin/mysqldump --no-create-db --no-create-info --compatible=postgresql --default-character-set=utf8 -r ${table}.sql -u bitnami bitnami_gitlab ${table} -p${mysql_password}

#转换成 PostgreSQL表格
echo "start convert table ${table}"
python ./db_converter.py ${table}.sql ${table}.psql
