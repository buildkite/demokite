#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -xeuo pipefail # don't print executed commands to the terminal

# source shared functions
source .buildkite/assets/functions.sh;

# upload behind the scenes annotation
behind_the_scenes_annotation "dynamic-annotation"

# change into steps/dynamic-annotation/ directory
cd .buildkite/steps/dynamic-annotation/;

ANNOTATION_CONTEXT="deploy-01"
CONTENT=""

ANNOTATION_STYLE="info"
ANNOTATION_TITLE="I'm a dynamically updating annotation!"
ANNOTATION_STATUS=":bk-status-running: In Progress"
ANNOTATION_PROGRESS=""
ANNOTATION_BODY="<div></div>"

function update-annotation (){
CONTENT=$(cat <<EOF
  <section>
    <h1 class="h4">$ANNOTATION_TITLE</h1>
    <table>
      <thead>
        <tr>
          <th>Status</th>
          <th>Progress</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>$ANNOTATION_STATUS</td>
          <td>$ANNOTATION_PROGRESS</td>
        </tr>
      </tbody>
    </table>
    <br/>$ANNOTATION_BODY<br/>
    <div class="mt2">
      <p class="h6 mregular italic">Last updated: $(date +"%Y-%m-%d %H:%M:%S")</p>
    </div>
  </section>
EOF
)

buildkite-agent annotate --context "$ANNOTATION_CONTEXT" --style "$ANNOTATION_STYLE" "$CONTENT"
}

function create-progress-emojis() {
  local progress_emojis_text=""
  local current_progress="$1"
  local total_progress="$2"

  for i in $(seq 1 $total_progress); do
    if [ $i -le $current_progress ]; then
      progress_emojis_text="$progress_emojis_text :large_green_circle:"
    else
      progress_emojis_text="$progress_emojis_text :white_circle:"
    fi
  done

  echo "$progress_emojis_text"
}

TOTAL_PROGRESS_BARS=10
CURRENT_PROGRESS=0
UPDATE_AFTER=1
PROGRESS_EMOJIS=""

while [ $CURRENT_PROGRESS -lt $TOTAL_PROGRESS_BARS ]; do
  ANNOTATION_PROGRESS=$(create-progress-emojis $CURRENT_PROGRESS $TOTAL_PROGRESS_BARS)
  update-annotation;

  CURRENT_PROGRESS=$(($CURRENT_PROGRESS + 1))
  sleep $UPDATE_AFTER
done

ANNOTATION_PROGRESS=$(create-progress-emojis $TOTAL_PROGRESS_BARS $TOTAL_PROGRESS_BARS)
ANNOTATION_TITLE=":partyparrot: :partyparrot: :partyparrot: HAZZAH! :partyparrot: :partyparrot: :partyparrot:"
ANNOTATION_STATUS=":bk-status-passed: Completed"
ANNOTATION_STYLE="success"
ANNOTATION_BODY=$(cat <<EOF
  <img src="artifact://.buildkite/assets/behind-the-scenes/excited.gif" alt="excited-face" title="Tadahh!" width="320" />
EOF
)

update-annotation;

buildkite-agent meta-data set "annotations" "dynamic"

cd ../ask;
pipeline_upload "ask.yml"
