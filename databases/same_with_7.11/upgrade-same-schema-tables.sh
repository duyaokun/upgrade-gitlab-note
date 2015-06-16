#!/bin/bash
same_tables=("events" "forked_project_links" "keys" "issues" "merge_request_diffs" "merge_requests" "milestones" "namespaces" "taggings")
action=$1
echo ${action}

if [ "$action" == "import" ]; then
  echo "Start import database to PostgreSQL"
  
  for table in ${same_tables[@]}
  do
    echo "Start import table ${table}"
    ../import.sh ${table}
  done
  
else
  echo "Start export database from MySQL"

  for table in ${same_tables[@]}
  do
    ../export.sh ${table}
  done

  echo "start tar mysql files"
  ../tar_sql_files.sh sql mysql

  echo "start tar psql files"
  ../tar_sql_files.sh psql psql
fi