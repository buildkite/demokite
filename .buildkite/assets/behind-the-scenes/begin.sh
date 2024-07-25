#!/bin/bash

set -euo pipefail

export TITLE=":wave: Hey there!"

export SUBTITLE=$(cat <<EOF
<p>
  :tada: Welcome to the starter pipeline :rainbow: - you just ran the first step! To continue the build, click the <strong>:thinking_face: What now?</strong> <a target="_blank" href="https://buildkite.com/docs/pipelines/block-step">block step</a> in the build header above.
</p>

<img class="rounded" src="artifact://.buildkite/assets/behind-the-scenes/block-step.png" alt="block-step" width="660" />
EOF
)

export DETAILS=$(cat <<EOF
<p>
  The first step in this build is a command step. It ran the <code>demokite.sh</code> script, which detected that since this was the first step, it should

  dynamically uploaded the welcome annotation, along with some more steps, including the <strong>:thinking_face: What now?</strong> block step.
</p>
EOF
)
