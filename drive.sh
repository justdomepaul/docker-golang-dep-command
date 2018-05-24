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

function go() { #cmd docker-compose run --rm golang go {golang subcommand }
    docker-compose run --rm golang go $@
}

function get() { #cmd docker-compose run --rm golang go get {package url}
    docker-compose run --rm golang go get $@
}

function fmt() { #cmd docker-compose run --rm golang go get {dir path OR ./...}
    docker-compose run --rm golang go fmt $@
}

function run() { #cmd docker-compose run --rm golang go run {file path}
    docker-compose run --rm golang go fmt $@ && docker-compose run --rm golang env GO15VENDOREXPERIMENT=1 go run $@
}

function test() { #cmd docker-compose run --rm golang go test {test dir path OR ./...}
    docker-compose run --rm golang go fmt $@ && docker-compose run --rm golang go test $@
}

function installMac() { #cmd docker-compose run --rm golang go install {dir path OR ./...}
    docker-compose run --rm golang go clean && docker-compose run --rm golang env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go install $@
}

function installLinux() { #cmd docker-compose run --rm golang go install {dir path OR ./...}
    docker-compose run --rm golang go clean && docker-compose run --rm golang env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go install $@
}

function installWindow() { #cmd docker-compose run --rm golang go install -o {dir path OR ./...}
    docker-compose run --rm golang go clean && docker-compose run --rm golang env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go install $@
}



if [ $# -eq 0 ] ; then
	usage
else
	export COMPOSE_HTTP_TIMEOUT=600
	CMD=$1
	shift
	$CMD $@
fi
