
# exit when any command fails
set -e

exit_on_error() {
    exit_code=$1
    last_command=${@:2}
    if [ $exit_code -ne 0 ]; then
        >&2 echo "\"${last_command}\" command failed with exit code ${exit_code}."
        exit $exit_code
    fi
}

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'exit_on_error $? $last_command' EXIT

###############################################################################
if [ ! -z "$TRAVIS_BRANCH" ]; then
	export ENV=$TRAVIS_BRANCH
fi

#set default ENV to dev
if [ -z "$ENV" ]; then
	export ENV=`git rev-parse --abbrev-ref HEAD`
fi
