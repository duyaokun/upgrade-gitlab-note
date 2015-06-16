#!/bin/bash
tables=("events" "forked_project_links" "issues" "identities" "keys" "members" "merge_request_diffs" "merge_requests" "milestones" "namespaces" "notes" "projects" "protected_branches" "snippets" "taggings" "tags" "users")
action=$1

if [ "$action" == "import" ]; then
  echo "Start import database to PostgreSQL"
  
  for table in ${tables[@]}
  do
    echo "Start import table ${table}"
    ../import.sh ${table}
  done
  
else
  echo "Start export database from MySQL"
  local mysql_password="6645a79e86"

  # backup
  /opt/gitlab-6.9.2-1/mysql/bin/mysqldump -u bitnami -p${mysql_password} bitnami_gitlab > ../bitnami_gitlab.sql

  # prepared for export
  /opt/gitlab-6.9.2-1/mysql/bin/mysql -p${mysql_password} bitnami_gitlab < before-export.sql

  # export
  for table in ${tables[@]}
  do
    ../export.sh ${table} ${mysql_password}
  done

  # revert SQL changed
  /opt/gitlab-6.9.2-1/mysql/bin/mysql -p${mysql_password} bitnami_gitlab < after-export.sql

  echo "start tar mysql files"
  ../tar_sql_files.sh sql mysql

  echo "start tar psql files"
  ../tar_sql_files.sh psql psql
fi