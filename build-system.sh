
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

# $1 base compose directory (not in current directory)
pull() {
	#docker-compose pull
	for compose in *.yml; do
		compose_base=`basename $compose .yml`
	        base=""
        	if [ -n "$1" ]; then
                	base="-f $1"
	        fi

		docker-compose $base/$compose_base.yml -f $compose -p $compose_base pull --ignore-pull-failures
	done
}

###############################################################################
if [ ! -z "$TRAVIS_BRANCH" ]; then
	export ENV=$TRAVIS_BRANCH
fi

#set default ENV to dev
if [ -z "$ENV" ]; then
	export ENV=`git rev-parse --abbrev-ref HEAD`
fi
