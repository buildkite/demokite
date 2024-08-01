#!/bin/bash

set -euo pipefail

export TITLE=":hammer: Let's monitor some job retries..."
export SUBTITLE=$(cat <<EOF
<p>
  Check out the <a href="$BUILDKITE_BUILD_URL#$BUILDKITE_JOB_ID">:bird: Automatic Retry</a> step to see an automatic retry in action.
</p>
EOF
)

export DETAILS=$(cat <<EOF
<ul>
  <li>
    You selected the <strong>:bird:  Automatically retry a failed job</strong> option in the
    <strong>:thinking_face: What now?</strong> block step.
  </li>
  <li>
    This set build <a target="_blank" href="https://buildkite.com/docs/agent/v3/cli-meta-data">meta-data</a>
    (specifically, a key called <code>"choice"</code>) with a value of <code>"retry"</code> about what you would
    like to do next.
  </li>
  <li>
    The <strong>:robot_face: Process Input</strong> step read the meta-data using a <code>buildkite-agent meta-data get "choice"</code>
    command, and determined that it should dynamically upload the following steps via <code>retry.yml</code>:
    <pre>
      <code>
        ---
        steps:
          - label: ":bird: Automatic Retry"
            command: ".buildkite/steps/retry/retry.sh"
            retry:
              automatic:
                  - limit: 2
      </code>
    </pre>
    <p>
      In this case, the <code>retry</code> <a target="_blank" href="https://buildkite.com/docs/pipelines/command-step#retry-attributes">command step attribute</a> is configured to allow automatic retries, up to a limit of 2 times.
    </p>
  </li>
</ul>
EOF
)
