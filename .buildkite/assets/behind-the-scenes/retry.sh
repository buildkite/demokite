#!/bin/bash

set -euo pipefail

export TITLE=":hammer: Let's retry some jobs!"
export SUBTITLE="This step is configured to retry automatically if the job fails."

export DETAILS=$(cat <<EOF
<p>
  You selected the <strong>:people_holding_hands: Run some jobs in parallel</strong> option in the
  <strong>:thinking_face: What now?</strong> block step.

  This set build <a target="_blank" href="https://buildkite.com/docs/agent/v3/cli-meta-data">meta-data</a>
  (specifically, a key called <code>"choice"</code> with a value of <code>"retry"</code>) about what you would
  like to do next.

  The <strong>:robot_face: Process Input</strong> step read the meta-data using a <code>buildkite-agent meta-data get "choice"</code>
  command, and determined that because the selected option value was <code>"retry"</code> that it should dynamically upload the following steps via <code>retry.yml</code>:
<p>
<pre>
  <code>
---
steps:
  - label: ":bird: Automatic Retry"
    command: "if (($BUILDKITE_RETRY_COUNT > 0)); then echo pass; exit 0; else echo fail; exit 1; fi;"
    retry:
      automatic:
          - limit: 2
  </code>
</pre>
<p>
  In this case, the <code>retry</code> <a target="_blank" href="https://buildkite.com/docs/pipelines/command-step#retry-attributes">command step attribute</a> is configured to allow automatic retries, up to a limit of 2 times.
</p>
EOF
)
