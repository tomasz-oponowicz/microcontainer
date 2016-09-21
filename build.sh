#!/usr/bin/env bash

#
# Usage: ./build.sh <tag> <src>
#
# <tag>  a tag of a final image, default is "microcontainer"
# <src>  a source path in a build image to copy, default is "/app/dist/."
#

TAG=${1:-microcontainer}
TAG_BUILD="$TAG-build"
SRC=${2:-/app/dist/.}
DEST="build"

rm -R $DEST
mkdir $DEST

# Build artifacts
docker build -t $TAG_BUILD -f Dockerfile.build .

# Create a temporary container to copy artifacts
id=$(docker create $TAG_BUILD)

# Copy artifacts to the workspace
docker cp $id:$SRC $DEST

# Remove the temporary container
docker rm -v $id

# Build a lightweight image and reuse artifacts
docker build -t $TAG .