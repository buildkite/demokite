#!/bin/bash

set -euo pipefail

export TITLE=":rainbow: Did you know that annotations can be dynamic?"
export SUBTITLE="<p>Check out the example below showcasing the power of Buildkite's annotations</p>"

export DETAILS=$(cat <<EOF
<p>
  You selected the <strong>:rocket: Monitor the progress of your deployments</strong> option in the
  <strong>:thinking_face: What now?<strong/> block step.

  This set build <a target="_blank" href="https://buildkite.com/docs/agent/v3/cli-meta-data">meta-data</a>
  (specifically, a key called <code>"choice"</code> with a value of <code>"deploy-progress"</code>) about what you would
  like to do next.

  The <strong>:robot_face: Process Input</strong> step read the meta-data using a <code>buildkite-agent meta-data get "choice"</code>
  command, and determined that because the selected option value was <code>"deploy-progress"</code> that it should run a file called <code>deploy-progress.sh</code>.

  In <code>annotations.sh</code>, we used the <code>buildkite-agent annotate</code> <a target="_blank" href="https://buildkite.com/docs/agent/v3/cli-annotate">CLI command</a> to generate the annotation, and the <code>--context deploy-01</code> flag to update the annotation in place.
</p>
EOF
)
