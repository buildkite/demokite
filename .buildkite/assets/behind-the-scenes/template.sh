#!/bin/bash

set -euo pipefail

export ANNOTATION_BODY=$(cat <<EOF
<h1 class="h4">$TITLE</h1>

$SUBTITLE

<hr/>

<details>
  <summary><strong class="pl2">:buildkite: Behind the scenes :buildkite:</strong></summary>
  <div class="pl3">
    $DETAILS
  </div>
</details>
EOF
)
