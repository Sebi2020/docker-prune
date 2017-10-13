# docker-prune utility
## How to install docker-prune
To install docker-prune.sh copy it to your local bin folder:
(If you need superuser rights preprend lines with *sudo* or *su*)
```bash
$ cp ./docker-prune.sh /bin
$ chmod +x /bin/docker-prune.sh
$ cd /bin
$ ln -s ./docker-prune.sh docker-prune
```

## How to use
### Delete all stopped containers:
```bash
$ docker-prune -c
````

### Stop containers and delete them:
```bash
$ docker-prune -s -c
```

### Delete dangling images
```
$ docker-prune -i
```

### Delete all containers and dangling images
If you wish to delete only stopped containers rather than running containers, miss the `-s|--stop` flag.
```bash
$ docker-prune -a -s
```

## Usage
```bash
Usage: docker-prune [Options]

Options:
        -a|--all                the same as -i -c
        -i|--images             prune dangling images
        -c|--containers         prune all stopped containers
           -s|--stop            stop running containers before pruning

© 2017 Informatikonline.net (Sebi2020)
```