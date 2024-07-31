#!/bin/bash

set -euo pipefail

export TITLE=":wave: Hey there!"

export SUBTITLE=$(cat <<EOF
<p>
  :tada: Welcome to your starter build, powered by the magic of <a target="_blank" href="https://buildkite.com/docs/pipelines/defining-steps#dynamic-pipelines">dynamic pipelines</a>! :rainbow:
  The build is currently in a <em>blocked</em> state, and needs your input to continue.
  Click the <strong>:thinking_face: What now?</strong> <a target="_blank" href="https://buildkite.com/docs/pipelines/block-step">block step</a> in the build header above to get started:
</p>

<img class="rounded" src="artifact://.buildkite/assets/behind-the-scenes/block-step.png" alt="block-step" width="660" />
EOF
)

export DETAILS=$(cat <<EOF
<ul>
  <li>
    The first step in this build ran the command <code>buildkite-agent pipeline upload</code>.
  </li>
  <li>
    This uploaded the <strong>:magic_wand: Let's Begin</strong> from the <code>pipeline.yml</code> file.
  </li>
  <li>
    The <strong>:magic_wand: Let's Begin</strong> step ran the <code>demokite.sh</code> script.
  </li>
  <li>
    <code>demokite.sh</code> dynamically uploaded this welcome annotation, along with some more steps, including the <strong>:thinking_face: What now?</strong> block step.
  </li>
</ul>
EOF
)
