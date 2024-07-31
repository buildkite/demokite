#!/bin/bash

set -euo pipefail

export TITLE=":wave: Hey there!"

export SUBTITLE=$(cat <<EOF
<p>
  :tada: Welcome to your pipeline :rainbow: - you just ran the first step! To continue the build, click the <strong>:thinking_face: What now?</strong> <a target="_blank" href="https://buildkite.com/docs/pipelines/block-step">block step</a> in the build header above.
</p>

<img class="rounded" src="artifact://.buildkite/assets/behind-the-scenes/block-step.png" alt="block-step" width="660" />
EOF
)

export DETAILS=$(cat <<EOF
<p>
  The first step in this build ran the command <code>buildkite-agent pipeline upload</code>.
  This uploaded the <strong>:magic_wand: Let's Begin</strong> from the <code>pipeline.yml</code> file.
  The <strong>:magic_wand: Let's Begin</strong> step ran the <code>demokite.sh</code> script.
  This script dynamically uploaded this welcome annotation, along with some more steps, including the <strong>:thinking_face: What now?</strong> block step.
</p>
EOF
)
