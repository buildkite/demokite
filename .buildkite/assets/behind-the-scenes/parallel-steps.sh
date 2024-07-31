#!/bin/bash

set -euo pipefail

export TITLE=":zap: You ran some jobs in parallel!"
export SUBTITLE="<p><a target="_blank" href="https://buildkite.com/docs/agent/v3/cli-meta-data">Parallelism</a> is an attribute on a single command step which causes it to be split into many jobs.</p>"

export DETAILS=$(cat <<EOF
<ul>
  <li>
    You selected the <strong>:people_holding_hands: Run some jobs in parallel</strong> option in the
    <strong>:thinking_face: What now?</strong> block step.
  </li>
  <li>
    This set build <a target="_blank" href="https://buildkite.com/docs/agent/v3/cli-meta-data">meta-data</a>
    (specifically, a key called <code>"choice"</code>) with a value of <code>"parallel-steps"</code> about what you would
    like to do next.
  </li>
  <li>
    The <strong>:robot_face: Process Input</strong> step read the meta-data using a <code>buildkite-agent meta-data get "choice"</code>
    command, and determined that it should dynamically upload the following code snippet:
    <pre>
      <code>
        ---
        steps:
          - label: ":zap: Parallel Jobs"
            command: ".buildkite/steps/parallel-steps/parallel-steps.sh"
            parallelism: 10
      </code>
    </pre>
  </li>
</ul>
EOF
)
