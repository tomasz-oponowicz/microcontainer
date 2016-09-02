#!/usr/bin/env bash

# Set first argument if defined; Otherwise "microcontainer".
TAG=${1:-microcontainer}
TAG_BUILD="$TAG-build"
TARGET="build"

rm -R $TARGET
mkdir $TARGET

# Build artifacts
docker build -t $TAG_BUILD -f Dockerfile.build .

# Create a temporary container to copy artifacts
id=$(docker create $TAG_BUILD)

# Copy artifacts to the workspace
docker cp $id:/app/dist/. $TARGET

# Remove the temporary container
docker rm -v $id

# Build a lightweight image and reuse artifacts
docker build -t $TAG .