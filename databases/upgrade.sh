#!/bin/bash
tables=("events" "forked_project_links" "issues" "identities" "keys" "members" "merge_request_diffs" "merge_requests" "milestones" "namespaces" "notes" "projects" "protected_branches" "snippets" "taggings" "tags" "users")
action=$1
sql_folder="sql-files/"

if [ "$action" == "import" ]; then
  echo "Start import database to PostgreSQL"
  
  for table in ${tables[@]}
  do
    echo "Start import table ${table}"
    ./import.sh ${table}
  done
  
else
  mysql_password="6645a79e86"

  echo "backup"
  /opt/gitlab-6.9.2-1/mysql/bin/mysqldump -u bitnami -p${mysql_password} bitnami_gitlab > ../bitnami_gitlab.sql

  echo "prepared for export"
  /opt/gitlab-6.9.2-1/mysql/bin/mysql -u bitnami -p${mysql_password} bitnami_gitlab < ${sql_folder}before-export.sql

  echo "Start export database from MySQL"
  for table in ${tables[@]}
  do
    ./export.sh ${table} ${mysql_password}
  done

  echo "revert SQL changed"
  /opt/gitlab-6.9.2-1/mysql/bin/mysql -u bitnami -p${mysql_password} bitnami_gitlab < ${sql_folder}after-export.sql

  echo "start tar mysql files"
  ./tar_sql_files.sh sql mysql

  echo "start tar psql files"
  ./tar_sql_files.sh psql psql
fi