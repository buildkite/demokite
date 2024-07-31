#!/bin/bash

set -euo pipefail

export TITLE=":rainbow: Did you know that annotations can be dynamic?"
export SUBTITLE="<p><a target="_blank" href="https://buildkite.com/docs/agent/v3/cli-annotate">Annotations</a> can be dynamically updated during a build - this can be useful for things like test reporting, or monitoring deploys.</p>"

export DETAILS=$(cat <<EOF
<ul>
  <li>
    You selected the <strong>:rocket: Show an annotation updating dynamically</strong> option in the <strong>:thinking_face: What now?<strong/> block step.
  </li>
  <li>
    This set build <a target="_blank" href="https://buildkite.com/docs/agent/v3/cli-meta-data">meta-data</a>
    (specifically, a key called <code>"choice"</code>) with a value of <code>"dynamic-annotation"</code> about what you would
    like to do next.
  </li>
  <li>
    The <strong>:robot_face: Process Input</strong> step read the meta-data using the <code>buildkite-agent meta-data get "choice"</code> command,
    and determined that it should run a file called <code>dynamic-annotation.sh</code>.
  </li>
  <li>
    In <code>dynamic-annotation.sh</code>, we used the <code>buildkite-agent annotate</code> <a target="_blank" href="https://buildkite.com/docs/agent/v3/cli-annotate">CLI command</a> to generate the annotation, and the <code>--context dynamic</code> flag to update the annotation in place.
  </li>
</ul>
EOF
)
