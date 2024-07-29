#!/bin/bash

set -euo pipefail

export TITLE=":gift: You downloaded an artifact! :party:"
export SUBTITLE="<p>I wonder what it could be...</p>"

export DETAILS=$(cat <<EOF
<p>
  You selected the <strong>:gift: Download an artifact</strong> option in the <strong>:thinking_face: What now?</strong> block step.

  This set build <a target="_blank" href="https://buildkite.com/docs/agent/v3/cli-meta-data">meta-data</a> (specifically, a key called <code>"choice"</code>) with a value of <code>"artifact"</code>.

  The <strong>:robot_face: Process Input</strong> step read the meta-data using the <code>buildkite-agent meta-data get "choice"</code> command, and determined that because the selected option was <code>"artifact"</code> that it should run a file called <code>artifact.sh</code>.

  In <code>artifact.sh</code>, we used the <code>buildkite-agent artifact</code> <a target="_blank" href="https://buildkite.com/docs/agent/v3/cli-artifact">CLI command</a> to download an artifact.
</p>
EOF
)
