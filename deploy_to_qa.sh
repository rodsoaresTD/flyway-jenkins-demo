#!/bin/bash

while getopts ":db:env:" opt; do
  case $opt in
    db)
      db=${OPTARG}
      ;;
    env)
      env=${OPTARG}
     ;;
    \?)
      echo >&2 "Invalid option: -${OPTARG}"
      show_usage
      exit 1
      ;;
  esac
done

# Ensure DB exists
psql -d "postgres" -c "CREATE DATABASE [IF NOT EXISTS] $db-$env;"

# Apply migrations
/bin/bash flyway.sh -db $db -env $env