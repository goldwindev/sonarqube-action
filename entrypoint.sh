#!/bin/bash

set -e

echo "Run action"

REPOSITORY_NAME=$(basename "${GITHUB_REPOSITORY}")

[[ ! -z ${INPUT_PASSWORD} ]] && SONAR_PASSWORD="${INPUT_PASSWORD}" || SONAR_PASSWORD=""

DEBUG=""

if [ ${INPUT_DEBUG} == "true" ] ; then
DEBUG='-X'
fi

make sonar-coverage || echo 

if [[ ! -f "${GITHUB_WORKSPACE}/sonar-project.properties" ]]; then

  [[ -z ${INPUT_PROJECTKEY} ]] && SONAR_PROJECTKEY="${REPOSITORY_NAME}" || SONAR_PROJECTKEY="${INPUT_PROJECTKEY}"
  [[ -z ${INPUT_PROJECTNAME} ]] && SONAR_PROJECTNAME="${REPOSITORY_NAME}" || SONAR_PROJECTNAME="${INPUT_PROJECTNAME}"
  [[ -z ${INPUT_PROJECTVERSION} ]] && SONAR_PROJECTVERSION="" || SONAR_PROJECTVERSION="${INPUT_PROJECTVERSION}"

  sonar-scanner ${DEBUG} \
    -Dsonar.host.url=${INPUT_HOST} \
    -Dsonar.projectKey=${SONAR_PROJECTKEY} \
    -Dsonar.projectName=${SONAR_PROJECTNAME} \
    -Dsonar.projectVersion=${SONAR_PROJECTVERSION} \
    -Dsonar.projectBaseDir=${INPUT_PROJECTBASEDIR} \
    -Dsonar.login=${INPUT_LOGIN} \
    -Dsonar.password=${SONAR_PASSWORD} \
    -Dsonar.sources=. \
    -Dsonar.sourceEncoding=UTF-8
    -Dsonar.working.directory=/tmp/_work/sonarqube/${SONAR_PROJECTNAME}
else
  sonar-scanner ${DEBUG} \
    -Dsonar.host.url=${INPUT_HOST} \
    -Dsonar.projectBaseDir=${INPUT_PROJECTBASEDIR} \
    -Dsonar.login=${INPUT_LOGIN} \
    -Dsonar.password=${SONAR_PASSWORD}
    -Dsonar.working.directory=/tmp/_work/sonarqube/${SONAR_PROJECTNAME}
fi
