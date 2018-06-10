# docker-golang-dep-command
Thiis is a simple golang command by using docker to drive.

## Advantage
If you have docker environment, you can run golang command, need not install any golang environment and package.

## Version
1.0.0

## Usages

#### go command
```bash
$ ./drive.sh -e ./src/{project}/.env go {your golang subcommand}
```

#### get command
```bash
$ ./drive.sh -e ./src/{project}/.env get {packkage url}
```

#### fmt command
```bash
$ ./drive.sh -e ./src/{project}/.env fmt {dir path OR ./...}
```

#### run command
```bash
$ ./drive.sh -e ./src/{project}/.env run {file path}
```

#### test command
```bash
$ ./drive.sh -e ./src/{project}/.env test {dir path OR ./...}
```

#### installMac command
```bash
$ ./drive.sh -e ./src/{project}/.env installMac {dir path OR ./...}
```

#### installLinux command
```bash
$ ./drive.sh -e ./src/{project}/.env installLinux {dir path OR ./...}
```

#### installWindow command
```bash
$ ./drive.sh -e ./src/{project}/.env installWindow {dir path OR ./...}
```

#### dep command
```bash
$ ./vendor.sh -e ./src/{project}/.env dep {command}
```

#### dep init command
```bash
$ ./vendor.sh -e ./src/{project}/.env init
```

#### dep status command
```bash
$ ./vendor.sh -e ./src/{project}/.env status
```

#### dep ensure command
```bash
$ ./vendor.sh -e ./src/{project}/.env ensure
```

#### dep add command
```bash
$ ./vendor.sh -e ./src/{project}/.env add {package name}
```

#### dep update command
```bash
$ ./vendor.sh -e ./src/{project}/.env update {package name}
```

#### dep prune command
```bash
$ ./vendor.sh -e ./src/{project}/.env prune
```

#### dep version command
```bash
$ ./vendor.sh -e ./src/{project}/.env version
```

## Point

#### set .env file
1. change .env.example to .env
2. add PROJECT_NAME in .env
3. PROJECT_NAME is ./src/{project(include main.go) folder name}
4. move .env to your project folder
5. init dep and have -e environment parameters
```bash
$ ./vendor.sh -e ./src/{project}/.env init
```

