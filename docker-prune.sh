#!/bin/sh
# (© 2017) Sebastian Tilders
function print_copyright() {
	echo ""
	echo "© 2017 Informatikonline.net (Sebi2020)"
}
function print_usage() {
	echo "Usage: $0 [Options]"
	echo ""
	echo "Options:"
	echo "	-a|--all		the same as -i -c"
	echo "	-i|--images		prune dangling images"
	echo "	-c|--containers		prune all stopped containers"
	echo "	   -s|--stop		stop running containers before pruning"
	print_copyright
}

if [ $# -eq 0 ]; then
	print_usage
	exit 1
fi
while [[ $# -gt 0 ]]
do
	case $1 in
		-a|--all)
		    IMAGES=true
	    	CONTAINERS=true
		    shift
		    ;;
		-i|--images)
		    IMAGES=true
		    shift
		    ;;
		-c|--containers)
		    CONTAINERS=true
		    shift
		    ;;
		-s|--stop)
			STOPCONTAINERS=true
			shift
			;;
		*)
			echo "WARNING: Unkown flag $1"
			print_usage
			exit 1
			;;
	esac
done

if [ $CONTAINERS ]; then
	if [ $STOPCONTAINERS ]; then
	echo "[docker-cleanup] Stopping containers..."
	docker container ls -q | xargs --no-run-if-empty docker stop
	fi
	echo "[docker-cleanup] Cleanup containers..."
	docker container prune -f
else
	if [ $STOPCONTAINERS ]; then
		echo "INFO: -s|--stop can only used in conjunction with -c|--containers!"
		print_usage
		exit 1;
	fi
fi

if [ $IMAGES ]; then
	echo "[docker-cleanup] Cleanup dangling images..."
	docker image ls -q -f "dangling=true" | xargs --no-run-if-empty docker rmi
fi
echo "[docker-cleanup] Finished!"	
exit 0