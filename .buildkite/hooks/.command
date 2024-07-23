#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

echo -e "\033[35mrepository command hook here, hi! 👋\033[0m"

# source shared functions
. .buildkite/assets/functions.sh;

# capture directory and contents
cur_dir=$(pwd)
cur_dir_contents=$(ls -lah $cur_dir)

# print directory and contents
echo ""
echokite "  The current job working directory is:" white none normal
echokite "$cur_dir" blue none italic | sed -e 's/^/    /'
echokite "  The contents of that directory is:" white none normal
echokite "$cur_dir_contents" blue none italic | sed -e 's/^/    /'
echo ""

# rename the file from 'command.example' to 'command' to use this hook
# can we use this hook to run the orignally specified command?
# maybe it could be used as a wrapper?
echo "$BUILDKITE_COMMAND"
. "$BUILDKITE_COMMAND"
