#!/bin/bash
same_tables=("events" "forked_project_links" "issues" "merge_request_diffs" "milestones" "namespaces" "taggings")

for table in ${same_tables[@]}
do
  echo "start export table ${table}"
  ./export.sh ${table}
  echo "start convert table ${table}"
  python ../db_converter.py ${table}.sql ${table}.psql
done

function tar_sql_files(){
  local file_type=$1
  local folder=$2
  local tar_file=${folder}.tar.gz

  rm -rf ${folder}
  mkdir ${folder}
  mv *.${file_type} ${folder}
  rm ${tar_file}
  tar zcvf ${tar_file} ${folder}
  rm -rf ${folder}
}

echo "start tar mysql files"
tar_sql_files sql mysql

echo "start tar psql files"
tar_sql_files psql psql

