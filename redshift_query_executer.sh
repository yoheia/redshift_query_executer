#!/usr/bin/env bash

export LC_ALL=C
SCRIPT_BASE_NAME=$(basename $0 .sh)
CURRENT_DATE=`date '+%Y%m%d_%H%M%S'`
BASE_DIR=$(cd $(dirname $0);pwd)
LOG_DIR=${LOG_DIR:-log}

PSQL=${PSQL:-/usr/pgsql-13/bin/psql}
PG_HOST=${PG_HOST:-redshift-cluster-poc.ceyg6jv96hfq.ap-northeast-1.redshift.amazonaws.com}
PG_USER=${PG_USER:-dwh_tool_user}
PG_DB=${PG_DB:-dev}
PG_PORT=${PG_PORT:-5439}
SQL_SCRIPT=${SQL_SCRIPT:-stv_inflight.sql}

# create log directory, if not exist.
if [ ! -d "${LOG_DIR}" ]
then
    mkdir ${LOG_DIR}
fi

cd $BASE_DIR
${PSQL} "host=${PG_HOST} port=${PG_PORT} dbname=${PG_DB} user=${PG_USER}" -a -f ${SQL_SCRIPT} \
    > "${LOG_DIR}/${SCRIPT_BASE_NAME}_${CURRENT_DATE}.log" 2>&1 &
${PSQL} "host=${PG_HOST} port=${PG_PORT} dbname=${PG_DB} user=${PG_USER}" -a -f ${SQL_SCRIPT} \
    > "${LOG_DIR}/${SCRIPT_BASE_NAME}_${CURRENT_DATE}.log" 2>&1 &
