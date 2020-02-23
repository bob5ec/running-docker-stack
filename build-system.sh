
#set default env to dev
#export env=${env:-dev}

if [ -z "$env" ]; then
	export env=`git rev-parse --abbrev-ref HEAD`
fi
