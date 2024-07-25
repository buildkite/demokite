#!/bin/bash

set -euo pipefail

export TITLE=":terminal: Let's check out a job log"

export SUBTITLE=$(cat <<EOF
<p>
  Scroll down or <a href="$BUILDKITE_BUILD_URL#$BUILDKITE_JOB_ID">click here</a>
  to explore the log for the job that just ran.
</p>
EOF
)

export DETAILS=$(cat <<EOF
<p>
  You selected the <strong>:terminal: Show some cool log features</strong> option in the <strong>:thinking_face: What now?</strong/> block step.

  This set build <a target="_blank" href="https://buildkite.com/docs/agent/v3/cli-meta-data">meta-data</a> (specifically, a key called <code>"choice"</code> with a value of <code>"logs"</code>) about what you would like to do next.

  The <strong>:robot_face: Process Input</strong> step read the meta-data using a <code>buildkite-agent meta-data get "choice"</code> command, and determined that because the selected option value was <code>"logs"</code> that it should run a file called <code>logs.sh</code>.

  In <code>logs.sh</code>, we used a <code>bash</code> script to print a bunch of information to the job log!
</p>
EOF
)
