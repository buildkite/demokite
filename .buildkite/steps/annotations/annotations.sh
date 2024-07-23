#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

# source shared functions
. .buildkite/assets/functions.sh;

# capture original working directory
current_dir=$(pwd)
current_dir_contents=$(ls -lah $current_dir)

# change into steps/annotations/ directory
cd .buildkite/steps/annotations/;

# replace variables in annotation file
FILE_PATH="./assets/example01.md"

replace_file_var $FILE_PATH "\$BUILDKITE_BUILD_URL" "$BUILDKITE_BUILD_URL"
replace_file_var $FILE_PATH "\$BUILDKITE_JOB_ID" "$BUILDKITE_JOB_ID"
replace_file_var $FILE_PATH "\$BUILDKITE_LABEL" "$BUILDKITE_LABEL"

# annotate
buildkite-agent annotate 'Example `error` style annotation' --style 'error' --context 'ctx-error'
buildkite-agent annotate 'Example `warning` style annotation' --style 'warning' --context 'ctx-warning'
buildkite-agent annotate 'Example `default` style annotation' --context 'ctx-default'
buildkite-agent annotate 'Example `info` style annotation' --style 'info' --context 'ctx-info'

printf '%b\n' "$(cat $FILE_PATH)" | buildkite-agent annotate --style 'success' --context 'example'

# upload assets as artifacts
buildkite-agent artifact upload "assets/*" --log-level error;

# if [ -f "$FILE_PATH" ]; then

#   OLD_STRING="\$BUILDKITE_BUILD_URL"
#   NEW_STRING="$BUILDKITE_BUILD_URL"
#   sed -i "s|$OLD_STRING|$NEW_STRING|g" "$FILE_PATH"
#   echo "Replaced $OLD_STRING with $NEW_STRING"

#   OLD_STRING="\$BUILDKITE_JOB_ID"
#   NEW_STRING="$BUILDKITE_JOB_ID"
#   sed -i "s|$OLD_STRING|$NEW_STRING|g" "$FILE_PATH"
#   echo "Replaced $OLD_STRING with $NEW_STRING"
  
#   OLD_STRING="\$BUILDKITE_LABEL"
#   NEW_STRING="$BUILDKITE_LABEL"
#   sed -i "s|$OLD_STRING|$NEW_STRING|g" "$FILE_PATH"
#   echo "Replaced $OLD_STRING with $NEW_STRING"

# else
#     echo "Error: File does not exist."
# fi

# FILE="./assets/example01.md"

# SEARCH="BUILDKITE_BUILD_URL"
# REPLACE=$BUILDKITE_BUILD_URL
# sed -i -e "s/$SEARCH/$REPLACE" "./assets/example01.md"

# SEARCH="BUILDKITE_JOB_ID"
# REPLACE="$BUILDKITE_JOB_ID"
# sed -i -e "s/$SEARCH/$REPLACE" "./assets/example01.md"

# SEARCH="BUILDKITE_LABEL"
# REPLACE="$BUILDKITE_LABEL"
# sed -i -e "s/$SEARCH/$REPLACE" "./assets/example01.md"

# This annotation was created by job: <a href=\"${BUILDKITE_BUILD_URL}#$BUILDKITE_JOB_ID\">$BUILDKITE_LABEL</a>

# echo -e "<h2>h2 heading</h2>" | buildkite-agent annotate --style 'warning' --context '1'
# echo "<h2>h2 heading</h2>" | buildkite-agent annotate --style 'warning' --context '2'
# printf "<h2>h2 heading</h2>" | buildkite-agent annotate --style 'warning' --context '3'
# printf '%b\n' "<h2>h2 heading</h2>" | buildkite-agent annotate --style 'warning' --context '4'

# echo -e "<h4>h4 heading</h4>" | buildkite-agent annotate --style 'warning' --context '5'
# echo "<h4>h4 heading</h4>" | buildkite-agent annotate --style 'warning' --context '6'
# printf "<h4>h4 heading</h4>" | buildkite-agent annotate --style 'warning' --context '7'
# printf '%b\n' "<h4>h4 heading</h4>" | buildkite-agent annotate --style 'warning' --context '8'

# echo -e "<p class="h1">Pastrami 1</p>" | buildkite-agent annotate --style 'warning' --context '1'
# echo "<p class="h1">Pastrami 1</p>" | buildkite-agent annotate --style 'warning' --context '2'
# printf "<p class="h1">Pastrami 1</p>" | buildkite-agent annotate --style 'warning' --context '3'
# printf '%b\n' "<p class="h1">Pastrami 1</p>" | buildkite-agent annotate --style 'warning' --context '4'

# cat <<-____EOF | cat
# <details>
# <summary>Wiz Docker Image Scan for $image_name does not meet policy requirements</summary>
# \`\`\`term
# Results of the scan goes here
# \`\`\`
# </details>
# ____EOF | buildkite-agent annotate --style 'warning' --context 'example02'

# MY_TEST_VAR="test success"

# echo -e "\`\`\`term\nThis is a $MY_TEST_VAR \033[0;31mtest\033[0m\n\`\`\`" | buildkite-agent annotate --style 'warning' --context 'example02'

# cat <<EOT >> ./assets/test01.md
# line 1
# line 2
# EOT
# buildkite-agent artifact upload "assets/test01.md" --log-level error;
# printf '%b\n' "$(cat ./assets/test01.md)" | buildkite-agent annotate --style 'success' --context 'test01'

# cat <<EOT >> ./assets/test02.md
# \`\`\`term\nThis is a $MY_TEST_VAR \033[0;31mtest\033[0m\n\`\`\`
# line 2
# EOT
# buildkite-agent artifact upload "assets/test02.md" --log-level error;
# printf '%b\n' "$(cat ./assets/test02.md)" | buildkite-agent annotate --style 'success' --context 'test02'

# cat <<EOT >> ./assets/test03.md
# line 1
# \`\`\`term
# This is a $MY_TEST_VAR \033[0;31mtest\033[0m
# \`\`\`
# line 2
# EOT
# buildkite-agent artifact upload "assets/test03.md" --log-level error
# printf '%b\n' "$(cat ./assets/test03.md)" | buildkite-agent annotate --style 'success' --context 'test03'

# IMAGE_NAME="my-secured-image"
# ANNOTATION_STYLE="warning"

# cat <<EOF >> ./wiz-docker-scan-annotation.md


# <h2>h2 heading</h2>

# The above heading is h2 in html format

# <h2>
# h2 heading
# </h2>

# The above heading is h2 in html format

# <details>
#     <summary>
#     Wiz Docker Image Scan for <a href="artifact://wiz-docker-scan-annotation.md">$IMAGE_NAME</a> does not meet policy requirements.
#     </summary>

#     line 1

#     \`\`\`term
#     Results of the scan go \033[0;31mhere\033[0m
#     \`\`\`

#     line 2

# </details>
# EOF
# buildkite-agent artifact upload "./wiz-docker-scan-annotation.md" --log-level error
# printf '%b\n' "$(cat ./wiz-docker-scan-annotation.md)" | buildkite-agent annotate --context "ctx-wiz-docker-scan-01" --style "$ANNOTATION_STYLE"


# # this doesn't work
# echo -e "
# <details>
# <summary>
# Wiz Docker Image Scan for <a href=\"artifact://wiz-docker-scan-annotation.md\">$IMAGE_NAME</a> does not meet policy requirements.
# </summary>

# line 1

# This annotation was created by job: <a href=\"${BUILDKITE_BUILD_URL}#$BUILDKITE_JOB_ID\">$BUILDKITE_LABEL</a>

# The file used to generate this annotation was uploaded as <a href=\"artifact://wiz-docker-scan-annotation.md\">an artifact which can be found here</a>

# \`\`\`term
# Results of the scan go \033[0;31mhere\033[0m
# \`\`\`

# line 2

# </details>
# " | buildkite-agent annotate --context "ctx-wiz-docker-scan-02" --style "$ANNOTATION_STYLE"


# # this works
# echo -e "
# <details>
#   <summary>
#   Wiz Docker Image Scan for <a href=\"artifact://wiz-docker-scan-annotation.md\">$IMAGE_NAME</a> does not meet policy requirements.
#   </summary>

#   line 1

#   This annotation was created by job: <a href=\"${BUILDKITE_BUILD_URL}#$BUILDKITE_JOB_ID\">$BUILDKITE_LABEL</a>

#   The file used to generate this annotation was uploaded as <a href=\"artifact://wiz-docker-scan-annotation.md\">an artifact which can be found here</a>

#   \`\`\`term
#   Results of the scan go \033[0;31mhere\033[0m
#   \`\`\`

#   line 2

# </details>
# " | buildkite-agent annotate --context "ctx-wiz-docker-scan-03" --style "success"


# # this works
# echo -e "

# <h1 class="m0">No margin</h1>

# ## h2 heading

# The above heading is h2 in markdown format

# <h2>h2 heading</h2>

# The above heading is h2 in html format

# <h1>
# h1 heading
# </h1>

# <h2>
# h2 heading
# </h2>

# <h3>
# h3 heading
# </h3>

# <h4>
# h4 heading
# </h4>

# <details>

# ## h2 heading

# The above heading is h2 in markdown format

# <h2>h2 heading</h2>

# The above heading is h2 in html format

# <h2>
# h2 heading
# </h2>

# <summary>
# Wiz Docker Image Scan for <a href=\"artifact://wiz-docker-scan-annotation.md\">$IMAGE_NAME</a> does not meet policy requirements.
# </summary>

# line 1

# This annotation was created by job: <a href=\"${BUILDKITE_BUILD_URL}#$BUILDKITE_JOB_ID\">$BUILDKITE_LABEL</a>

# The file used to generate this annotation was uploaded as <a href=\"artifact://wiz-docker-scan-annotation.md\">an artifact which can be found here</a>

# \`\`\`term
# Results of the scan go \033[0;31mhere\033[0m
# \`\`\`

# line 2

# </details>
# " | buildkite-agent annotate --context "ctx-wiz-docker-scan-04" --style "success"

# # this works
# echo -e "
# <details>
# <summary>
# Wiz Docker Image Scan for <a href=\"artifact://wiz-docker-scan-annotation.md\">$IMAGE_NAME</a> does not meet policy requirements.
# </summary>
# <pre>
#     1 
#    / \ 
#   2   2 
#  / \ / \ 
# 3  4 4  3 
# </pre>

#     line 1

# This annotation was created by job: <a href=\"${BUILDKITE_BUILD_URL}#$BUILDKITE_JOB_ID\">$BUILDKITE_LABEL</a>

# The file used to generate this annotation was uploaded as <a href=\"artifact://wiz-docker-scan-annotation.md\">an artifact which can be found here</a>

# &nbsp;&nbsp;&nbsp;&nbsp;\`\`\`term
# &nbsp;&nbsp;&nbsp;&nbsp;Results of the scan go \033[0;31mhere\033[0m
# &nbsp;&nbsp;&nbsp;&nbsp;\`\`\`

#   line 2

# &nbsp;&nbsp;hello2

# &nbsp;&nbsp;&nbsp;&nbsp;hello4

# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hello6



# </details>
# " | buildkite-agent annotate --context "ctx-wiz-docker-scan-05" --style "success"


# echo -e "This annotation was created by job: <a href="${BUILDKITE_BUILD_URL}#$BUILDKITE_JOB_ID">$BUILDKITE_LABEL</a>"

# buildkite-agent annotate 'Example `default` style annotation' --context 'ctx-default'
# buildkite-agent annotate 'Example `info` style annotation' --style 'info' --context 'ctx-info'
# buildkite-agent annotate 'Example `success` style annotation' --style 'success' --context 'ctx-success'
# buildkite-agent annotate 'Example `warning` style annotation' --style 'warning' --context 'ctx-warning'
# buildkite-agent annotate 'Example `error` style annotation' --style 'error' --context 'ctx-error'

