#!/usr/bin/env bash

#
# Usage: ./build.sh <name> <tag> <src>
#
# <name> a repository name of a final image, default is "microcontainer"
# <tag>  a version, default is "latest"
# <src>  a path used to copy artifacts from a build image, default is "/app/dist/."
#

set -e

NAME=${1:-microcontainer}
NAME_BUILD="$NAME-build"
TAG=${2:-latest}
SRC=${3:-/app/dist/.}
DEST="build"

echo "Building $NAME:$TAG from `pwd`"

rm -Rf $DEST
mkdir $DEST

# Build artifacts
docker build -t $NAME_BUILD:$TAG -f Dockerfile.build .

# Create a temporary container to copy artifacts
id=$(docker create $NAME_BUILD:$TAG)

# Copy artifacts to the workspace
docker cp $id:$SRC $DEST

# Remove the temporary container
docker rm -v $id

# Build a lightweight image and reuse artifacts
docker build -t $NAME:$TAG .