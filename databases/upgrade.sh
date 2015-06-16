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

  for table in ${tables[@]}
  do
    ../export.sh ${table}
  done

  echo "start tar mysql files"
  ../tar_sql_files.sh sql mysql

  echo "start tar psql files"
  ../tar_sql_files.sh psql psql
fi