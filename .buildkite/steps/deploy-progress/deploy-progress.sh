#!/bin/bash

# TODO
# - [ ] Create function for updating end time
# - [ ] Create function for updating start time
# - [ ] Create function for updating deployment progress
# - [ ] Create function for updating old and new deployment versions
# - [ ] Link Buildkite job
# - [ ] Add margins to table headers to avoid it moving around as its populated
# - [ ] Add "approved by this_person" into annotation
# - [ ] Add margins to table headers to avoid it moving around as its populated


# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

# source shared functions
. .buildkite/assets/functions.sh;

# capture original working directory
current_dir=$(pwd);
current_dir_contents=$(ls -lah $current_dir);

# change into step directory
cd .buildkite/steps/deploy-progress/;

# source local functions
source ./assets/functions.sh;

# upload assets as artifacts
# buildkite-agent artifact upload "assets/*.gif" --log-level error;

generate_commit_url() {
  local repo_url="$1"
  local commit_hash="$2"
  # Remove the .git suffix if it exists
  repo_url="${repo_url%.git}"
  # Construct the commit URL
  local commit_url="${repo_url}/commit/${commit_hash}"
  echo "$commit_url"
}

# Function to generate progress circles
generate_progress_circles() {
  local percentage="$1"
  local filled_circles=$(( (percentage + 19) / 20 )) # Round up to nearest 20%
  local empty_circles=$(( 5 - filled_circles ))
  local result=""

  for ((i = 0; i < filled_circles; i++)); do
    result+=":large_green_circle:"
  done

  for ((i = 0; i < empty_circles; i++)); do
    result+=":white_circle:"
  done

  echo "$result"
}

# Function to update progress for multiple deployments
update_deployment_progress() {
  local percentage="$1"
  local sleep_interval="$2"
  shift 2
  local deployment_keys=("$@")

  local progress=$(generate_progress_circles "$percentage")

  for deployment_key in "${deployment_keys[@]}"; do
    update_json --key "$deployment_key.deployment_progress.text" --value "$progress"
  done

  update_annotation
  sleep "$sleep_interval"
}

# # Example usage
# update_deployment_progress 20 2 "deployments.llama-dev" "deployments.kangaroo-dev"
# update_deployment_progress 40 2 "deployments.llama-dev" "deployments.kangaroo-dev"
# update_deployment_progress 60 2 "deployments.llama-dev" "deployments.kangaroo-dev"


# generate progress circles
progress_0=$(generate_progress_circles 0)
progress_20=$(generate_progress_circles 20)
progress_40=$(generate_progress_circles 40)
progress_60=$(generate_progress_circles 60)
progress_80=$(generate_progress_circles 80)
progress_100=$(generate_progress_circles 100)

# get git commits and url
minus_2_commit_short=$(git log -1 --pretty=format:%h HEAD~2)
previous_commit_short=$(git log -1 --pretty=format:%h HEAD~1)
current_commit_short=$(git log -1 --pretty=format:%h)

minus_2_commit_long=$(git log -1 --pretty=format:%H HEAD~2)
previous_commit_long=$(git log -1 --pretty=format:%H HEAD~1)
current_commit_long=$(git log -1 --pretty=format:%H)

minus_2_commit_url=$(generate_commit_url "$BUILDKITE_REPO" "$BUILDKITE_COMMIT")
previous_commit_url=$(generate_commit_url "$BUILDKITE_REPO" "$previous_commit_long")
current_commit_url=$(generate_commit_url "$BUILDKITE_REPO" "$current_commit_long")

# update old and new deployment versions
update_json --key "deployments.llama-dev.old_version.text" --value "$previous_commit_short"
update_json --key "deployments.llama-dev.old_version.title" --value "$previous_commit_long"
update_json --key "deployments.llama-dev.old_version.link" --value "$previous_commit_url"
update_json --key "deployments.llama-dev.new_version.text" --value "$current_commit_short"
update_json --key "deployments.llama-dev.new_version.title" --value "$current_commit_long"
update_json --key "deployments.llama-dev.new_version.link" --value "$current_commit_url"

update_json --key "deployments.llama-prod.old_version.text" --value "$previous_commit_short"
update_json --key "deployments.llama-prod.old_version.title" --value "$previous_commit_long"
update_json --key "deployments.llama-prod.old_version.link" --value "$previous_commit_url"
update_json --key "deployments.llama-prod.new_version.text" --value "$current_commit_short"
update_json --key "deployments.llama-prod.new_version.title" --value "$current_commit_long"
update_json --key "deployments.llama-prod.new_version.link" --value "$current_commit_url"

update_json --key "deployments.kangaroo-dev.old_version.text" --value "$minus_2_commit_short"
update_json --key "deployments.kangaroo-dev.old_version.title" --value "$minus_2_commit_long"
update_json --key "deployments.kangaroo-dev.old_version.link" --value "$minus_2_commit_url"
update_json --key "deployments.kangaroo-dev.new_version.text" --value "$current_commit_short"
update_json --key "deployments.kangaroo-dev.new_version.title" --value "$current_commit_long"
update_json --key "deployments.kangaroo-dev.new_version.link" --value "$current_commit_url"

update_json --key "deployments.kangaroo-prod.old_version.text" --value "$minus_2_commit_short"
update_json --key "deployments.kangaroo-prod.old_version.title" --value "$minus_2_commit_long"
update_json --key "deployments.kangaroo-prod.old_version.link" --value "$minus_2_commit_url"
update_json --key "deployments.kangaroo-prod.new_version.text" --value "$current_commit_short"
update_json --key "deployments.kangaroo-prod.new_version.title" --value "$current_commit_long"
update_json --key "deployments.kangaroo-prod.new_version.link" --value "$current_commit_url"
update_annotation
sleep 2

# Function to calculate duration
calculate_duration() {
  local current_time_epoch=$(date +"%s")
  echo "$((current_time_epoch - start_time_epoch))s"
}

deployment_key="deployments.llama-dev"
start_time=$(date +"%Y-%m-%d %H:%M:%S")
start_time_epoch=$(date -d "$start_time" +"%s")
start_time_long=$(date -d "$start_time" +"%Y-%m-%d %H:%M:%S")
start_time_short=$(date -d "$start_time" +"%H:%M:%S")
update_json --key "$deployment_key.started.text" --value "$start_time_short"
update_json --key "$deployment_key.started.title" --value "$start_time_long"
update_json --key "$deployment_key.deployment_progress.text" --value "$progress_0"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-running:"
update_json --key "$deployment_key.deployment_status.text" --value "In Progress"
update_json --key "$deployment_key.deployment_status.class" --value "center bold orange"
update_annotation
sleep 2

deployment_key="deployments.kangaroo-dev"
start_time=$(date +"%Y-%m-%d %H:%M:%S")
start_time_epoch=$(date -d "$start_time" +"%s")
start_time_long=$(date -d "$start_time" +"%Y-%m-%d %H:%M:%S")
start_time_short=$(date -d "$start_time" +"%H:%M:%S")
update_json --key "$deployment_key.started.text" --value "$start_time_short"
update_json --key "$deployment_key.started.title" --value "$start_time_long"
update_json --key "$deployment_key.deployment_progress.text" --value "$progress_0"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-running:"
update_json --key "$deployment_key.deployment_status.text" --value "In Progress"
update_json --key "$deployment_key.deployment_status.class" --value "center bold orange"
update_annotation
sleep 2

deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.deployment_progress.text" --value "$progress_20"
update_annotation
sleep 2

deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.deployment_progress.text" --value "$progress_40"
update_annotation
sleep 2

deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.deployment_progress.text" --value "$progress_20"
update_annotation
sleep 2

deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.deployment_progress.text" --value "$progress_40"
update_annotation
sleep 2

deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.deployment_progress.text" --value "$progress_60"
deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.deployment_progress.text" --value "$progress_60"
update_annotation
sleep 2

deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.deployment_progress.text" --value "$progress_80"
update_annotation
sleep 2

deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.deployment_progress.text" --value "$progress_80"
update_annotation
sleep 2

deployment_key="deployments.llama-dev"
end_time=$(date +"%Y-%m-%d %H:%M:%S")
end_time_epoch=$(date -d "$end_time" +"%s")
end_time_long=$(date -d "$end_time" +"%Y-%m-%d %H:%M:%S")
end_time_short=$(date -d "$end_time" +"%H:%M:%S")
update_json --key "$deployment_key.finished.text" --value "$end_time_short"
update_json --key "$deployment_key.finished.title" --value "$end_time_long"
update_json --key "$deployment_key.deployment_progress.text" --value "$progress_100"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-passed:"
update_json --key "$deployment_key.deployment_status.text" --value "Completed"
update_json --key "$deployment_key.deployment_status.class" --value "center bold green"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 2

deployment_key="deployments.kangaroo-dev"
end_time=$(date +"%Y-%m-%d %H:%M:%S")
end_time_epoch=$(date -d "$end_time" +"%s")
end_time_long=$(date -d "$end_time" +"%Y-%m-%d %H:%M:%S")
end_time_short=$(date -d "$end_time" +"%H:%M:%S")
update_json --key "$deployment_key.finished.text" --value "$end_time_short"
update_json --key "$deployment_key.finished.title" --value "$end_time_long"
update_json --key "$deployment_key.deployment_progress.text" --value "$progress_100"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-passed:"
update_json --key "$deployment_key.deployment_status.text" --value "Completed"
update_json --key "$deployment_key.deployment_status.class" --value "center bold green"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"

# Update the image attributes
update_json --key "tr_image.src" --value "https://66.media.tumblr.com/598227a61e3cc5d53c5e35e3ccd100ac/tumblr_mjoko81kiY1rfjowdo1_500.gif"
update_json --key "tr_image.alt" --value "A different rainbow cat"
update_json --key "tr_image.title" --value "meow yay meow!"
update_json --key "tr_image.width" --value "55"
# update_json --key "tr_image.height" --value "55"
update_json --key "tr_image.class" --value "mt0"
update_annotation --debug "debug";
sleep 2

deployment_key="deployments.llama-prod"
start_time=$(date +"%Y-%m-%d %H:%M:%S")
start_time_epoch=$(date -d "$start_time" +"%s")
start_time_long=$(date -d "$start_time" +"%Y-%m-%d %H:%M:%S")
start_time_short=$(date -d "$start_time" +"%H:%M:%S")
update_json --key "$deployment_key.started.text" --value "$start_time_short"
update_json --key "$deployment_key.started.title" --value "$start_time_long"
update_json --key "$deployment_key.deployment_progress.text" --value "$progress_0"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-running:"
update_json --key "$deployment_key.deployment_status.text" --value "In Progress"
update_json --key "$deployment_key.deployment_status.class" --value "center bold orange"
update_annotation
sleep 1

update_json --key "$deployment_key.deployment_progress.text" --value "$progress_20"
update_annotation
sleep 2

update_json --key "$deployment_key.deployment_progress.text" --value "$progress_40"
update_annotation
sleep 2

update_json --key "$deployment_key.deployment_progress.text" --value "$progress_60"
update_annotation
sleep 2

update_json --key "$deployment_key.deployment_progress.text" --value "$progress_80"
update_annotation
sleep 2

end_time=$(date +"%Y-%m-%d %H:%M:%S")
end_time_epoch=$(date -d "$end_time" +"%s")
end_time_long=$(date -d "$end_time" +"%Y-%m-%d %H:%M:%S")
end_time_short=$(date -d "$end_time" +"%H:%M:%S")
update_json --key "$deployment_key.finished.text" --value "$end_time_short"
update_json --key "$deployment_key.finished.title" --value "$end_time_long"
update_json --key "$deployment_key.deployment_progress.text" --value "$progress_100"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-passed:"
update_json --key "$deployment_key.deployment_status.text" --value "Completed"
update_json --key "$deployment_key.deployment_status.class" --value "center bold green"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation

buildkite-agent annotate --style "success" --context "deploy-01"

ls -lah ./assets/;

cd ../ask;

pipeline_upload "ask.yml"
