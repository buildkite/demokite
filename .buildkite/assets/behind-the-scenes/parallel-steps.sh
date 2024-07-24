#!/bin/bash

set -euo pipefail

export TITLE=":zap: Did you know that steps can be run in parallel?"
export SUBTITLE="<p>Check out the example below showcasing the power of Buildkite's parallelism</p>"

export DETAILS=$(cat <<EOF
<p>
  You selected the <strong>:people_holding_hands: Run some jobs in parallel</strong> option in the
  <strong>:thinking_face: What now?</strong> block step.

  This set build <a target="_blank" href="https://buildkite.com/docs/agent/v3/cli-meta-data">meta-data</a>
  (specifically, a key called <code>"choice"</code> with a value of <code>"parallel-steps"</code>) about what you would
  like to do next.

  The <strong>:robot_face: Process Input</strong> step read the meta-data using a <code>buildkite-agent meta-data get "choice"</code>
  command, and determined that because the selected option value was <code>"parallel-steps"</code> that it should dynamically upload the following code snippet:
<p>
<pre>
  <code>
---
steps:
  - label: ":zap: Parallel Steps"
    command: ".buildkite/steps/parallel-steps/parallel-steps.sh"
    parallelism: 10
  </code>
</pre>
<p>
  You'll notice the <code>parallelism: 10</code> automatically created 10 steps that will each run a file called <code>.buildkite/steps/parallel-steps/parallel-steps.sh</code>. This bash script runs a sleep command for a random interval of seconds to demonstrate that these steps are running concurrently at finishing at different times.
</p>
EOF
)