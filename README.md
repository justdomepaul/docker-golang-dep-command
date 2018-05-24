# docker-golang-dep-command
Thiis is a simple golang command by using docker to drive.

## Advantage
If you have docker environment, you can run golang command, need not install any golang environment and package.

## Version
1.0.0

## Usages

#### go command
```bash
$ ./drive.sh go {your golang subcommand}
```

#### get command
```bash
$ ./drive.sh get {packkage url}
```

#### fmt command
```bash
$ ./drive.sh fmt {dir path OR ./...}
```

#### run command
```bash
$ ./drive.sh run {file path}
```

#### test command
```bash
$ ./drive.sh test {dir path OR ./...}
```

#### installMac command
```bash
$ ./drive.sh installMac {dir path OR ./...}
```

#### installLinux command
```bash
$ ./drive.sh installLinux {dir path OR ./...}
```

#### installWindow command
```bash
$ ./drive.sh installWindow {dir path OR ./...}
```

#### dep command
```bash
$ ./vendor.sh dep {command}
```

#### dep init command
```bash
$ ./vendor.sh init
```

#### dep status command
```bash
$ ./vendor.sh status
```

#### dep ensure command
```bash
$ ./vendor.sh ensure
```

#### dep add command
```bash
$ ./vendor.sh add {package name}
```

#### dep update command
```bash
$ ./vendor.sh update {package name}
```

#### dep prune command
```bash
$ ./vendor.sh prune
```

#### dep version command
```bash
$ ./vendor.sh version
```

## Point

#### set .env file
1. change .env.example to .env
2. add PROJECT_NAME in .env
3. PROJECT_NAME is ./src/{project(include main.go) folder name}
4. init dep
```bash
$ ./vendor.sh init
```

