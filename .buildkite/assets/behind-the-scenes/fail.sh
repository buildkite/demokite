#!/bin/bash

set -euo pipefail

export TITLE=":x: The build failed!"
export SUBTITLE=$(cat <<EOF
<p>
  <i>Keen for another adventure?</i> Click the <strong>Rebuild</strong> button in the build header above to run this build again!
</p>
<img class="rounded" src="artifact://.buildkite/assets/behind-the-scenes/rebuild-button.png" alt="rebuild-button" width="660" />
EOF
)

export DETAILS=$(cat <<EOF
<p>
  You selected the <strong>:thumbsup: Pass the build</strong> option in the
  <strong>:thinking_face: What now?<strong/> block step.

  This set build <a target="_blank" href="https://buildkite.com/docs/agent/v3/cli-meta-data">meta-data</a>
  (specifically, a key called <code>"choice"</code> with a value of <code>"fail"</code>) about what you would
  like to do next.

  The <strong>:robot_face: Process Input</strong> step read the meta-data using a <code>buildkite-agent meta-data get "choice"</code>
  command, and determined that the because the selected option value was <code>"fail"</code> that all the build
  needed to do was <code>exit 1</code>.

  This caused the step to fail and therefore the state of the build is <code>"failed"</code>
</p>
EOF
)
