#!/usr/bin/env bash
set -e
cd $( cd $(dirname $0) ; pwd -P )
[ -f .env ] && export $(cat .env | xargs) || echo "there is no .env, skip"

function usage () {
	cat <<EOS
To execute pre-defined commands with Docker.
Usage:
	$(basename $0) <Command> [args...]
Command:
EOS
	egrep -o "^\s*function.*#cmd.*" $(basename $0) | sed "s/^[ \t]*function//" | sed "s/[ \(\)\{\}]*#cmd//" \
	    | awk '{CMD=$1; $1=""; printf "\t%-16s%s\n", CMD, $0}'
}

function dep() { #cmd docker-compose run --rm dep {command}
    docker-compose run --rm dep $@
}

function init() { #cmd docker-compose run --rm dep init
    docker-compose run --rm dep init
}

function status() { #cmd docker-compose run --rm dep status
    docker-compose run --rm dep status
}

function ensure() { #cmd docker-compose run --rm dep ensure
    docker-compose run --rm dep ensure
}

function add() { #cmd docker-compose run --rm dep ensure -add {package name}
    docker-compose run --rm dep ensure -add $@
}

function update() { #cmd docker-compose run --rm dep ensure -update {package name}
    docker-compose run --rm dep ensure -update $@
}

function prune() { #cmd docker-compose run --rm dep prune
    docker-compose run --rm dep prune
}

function version() { #cmd docker-compose run --rm dep version
    docker-compose run --rm dep version
}

if [ $# -eq 0 ] ; then
	usage
else
	export COMPOSE_HTTP_TIMEOUT=600
	CMD=$1
	shift
	$CMD $@
fi
