#!/bin/bash

if [[ ! -d poky ]]; then
	if [[ -d ../poky ]]; then
		cd ..
	else
		echo "run this in the correct directory..........."
		exit 1
	fi
fi

./build/deps.sh

DIRPATH="$(pwd)"

#docker build --build-arg DIR_PATH="${DIRPATH}" --build-arg USER_NAME=$(whoami) --build-arg UID=$(id -u $USER) --build-arg GID=$(id -g $USER) -t vic-yocto-builder-2 build/

VARI="perf"

if [[ ${PROD} == "1" ]]; then
	VARI="user"
fi

docker run -it --rm \
    -v $(pwd)/anki-deps:${HOME}/.anki \
    -v $(pwd):$(pwd) \
    -v $(pwd)/build/cache:${HOME}/.ccache \
    rebuild-yocto-builder-7 bash -c "cd $(pwd)/poky && source build/conf/set_bb_env.sh && MACHINE=apq8009-robot VARIANT=perf DISTRO=msm-${VARI} PRODUCT=robot bitbake -c cleanall $@"
