#!/bin/bash
#import databases to postgresql
psql_user="gitlab"
psql_path="/opt/gitlab/embedded/bin/"
table_name=$1

$ sudo -u ${psql_user} ${psql_path}psql -d gitlabhq_production -f ${table_name}.psql
