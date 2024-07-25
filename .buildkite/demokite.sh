#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

# source shared functions
. .buildkite/assets/functions.sh;

CHOICE_ANNOTATIONS=""
CHOICE_LOGS=""
CHOICE_PARALLELISM=""
CHOICE_BUILD_PASS=""
CHOICE_BUILD_FAIL=""
CHOICES=""

CURRENT_STATE=""
FIRST_STEP_KEY="begin"
CURRENT_DIR=$(pwd)

if [ "$BUILDKITE_STEP_KEY" != "$FIRST_STEP_KEY" ]; then
  CURRENT_STATE=$(buildkite-agent meta-data get "choice")
  echo "BUILDKITE_STEP_KEY: $BUILDKITE_STEP_KEY"
  echo "CHOICE: $CURRENT_STATE"
  if [ $CURRENT_STATE = "logs" ]; then
    pipeline_upload ".buildkite/steps/logs/logs.yml"
  fi
  if [ $CURRENT_STATE = "annotations" ]; then
    pipeline_upload ".buildkite/steps/annotations/annotations.yml"
  fi
  if [ $CURRENT_STATE = "parallel-steps" ]; then
    pipeline_upload ".buildkite/steps/parallel-steps/parallel-steps.yml"
  fi
  if [ $CURRENT_STATE = "deploy-progress" ]; then
    pipeline_upload ".buildkite/steps/deploy-progress/deploy-progress.yml"
  fi
  if [ $CURRENT_STATE = "pass" ]; then
    artifact_upload ".buildkite/assets/behind-the-scenes/rebuild-button.png"
    pipeline_upload ".buildkite/steps/pass/pass.yml"
  fi
  if [ $CURRENT_STATE = "fail" ]; then
    artifact_upload ".buildkite/assets/behind-the-scenes/rebuild-button.png"
    pipeline_upload ".buildkite/steps/fail/fail.yml"
  fi

  behind_the_scenes_annotation "$CURRENT_STATE"
else
  sleep 10
  pipeline_upload ".buildkite/steps/ask/ask.yml"
fi
