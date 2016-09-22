# Microcontainer

A small script which helps you shrink a size of a Docker image.

Unfortunately Docker doesn't solve the problem of large images out of the box. [Squashing images](https://github.com/jwilder/docker-squash) can help but it forces you to include extra cleanup commands. Sometimes this can be a headache.

The solution is to split responsibilities between `Dockerfile.build` and `Dockerfile`.

`Dockerfile.build` builds application artifacts. This can be anything, from a static website to a standalone application.

`Dockerfile` is an execution environment. Artifacts, from the previous image, are copied here. Development tools aren't included which allows you to create a ridiculously small image.

The `example` directory contains a sample use case. This is a React application which requires development tools during build time. Thanks to the script the final image is very lightweight:

| Image                                   | Size     |
|-----------------------------------------|----------|
| microcontainer-build (Dockerfile.build) | 266.4 MB |
| microcontainer (Dockerfile)             | 5.271 MB |

## Usage

### Prerequisites

* [docker](https://www.docker.com/) is installed;

### Instructions

Execute:

    $ cd ./example
    $ ../build.sh
    $ docker run -p 80:80 microcontainer

...it's possible to define a custom name and artifacts path, for example:

    $ cd ./example
    $ ../build.sh mytag /workspace/.
    $ docker run -p 80:80 mytag

...more information in the `build.sh` file.

## What's next

Feel free to test it against your `Dockerfile.build` and `Dockerfile`.

