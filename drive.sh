#!/usr/bin/env bash
set -e
cd $( cd $(dirname $0) ; pwd -P )

ENV=".env"
while getopts "e:" OPTION
do
     case $OPTION in
         e)
            ENV=$OPTARG
            shift
            shift
            ;;
         ?)
            usage
            exit
            ;;
     esac
done

[ -f $ENV ] && export $(cat $ENV | xargs) || echo "there is no .env, skip"

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

function fmt() {
    docker-compose run --rm golang go fmt $@
}

function go () { #cmd docker-compose run --rm golang go
    docker-compose run --rm golang go $@
}

function get () { #cmd docker-compose run --rm golang go get {url}
    docker-compose run --rm golang go get $@
}

function run () { #cmd docker-compose run --rm golang go run {go file path}
    docker-compose run --rm golang go fmt $@ && docker-compose run --rm golang env GO15VENDOREXPERIMENT=1 go run $@
}

function test () { #cmd docker-compose run --rm golang go test {go test dir path}
    docker-compose run --rm golang go fmt $@ && docker-compose run --rm golang go test $@
}

function installMac () { #cmd docker-compose run --rm golang go install {go dir path}
    docker-compose run --rm golang go clean && docker-compose run --rm golang env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go install $@
}

function installLinux () { #cmd docker-compose run --rm golang go install {go dir path}
    docker-compose run --rm golang go clean && docker-compose run --rm golang env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go install $@
}

function installLinux386 () { #cmd docker-compose run --rm golang go install {go dir path}
    docker-compose run --rm golang go clean && docker-compose run --rm golang env CGO_ENABLED=0 GOOS=linux GOARCH=386 go install $@
}

function installLinuxArm () { #cmd docker-compose run --rm golang go install {go dir path}
    docker-compose run --rm golang go clean && docker-compose run --rm golang env GOOS=linux GOARCH=arm GOARM=7 go install $@
}

function installLinuxArm64 () { #cmd docker-compose run --rm golang go install {go dir path}
    docker-compose run --rm golang go clean && docker-compose run --rm golang env GOOS=linux GOARCH=arm64 GOARM=7 go install $@
}

function installWindow () { #cmd docker-compose run --rm golang go install -o {go dir path}
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
