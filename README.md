Distributes an application as a Docker image with minimal dependencies.

`Dockerfile.build` builds artifacts. `Dockerfile` contains minimal dependencies and reuses artifacts. The final image is very lightweight:

| Image                                   | Size     |
|-----------------------------------------|----------|
| microcontainer-build (Dockerfile.build) | 265.1 MB |
| microcontainer (Dockerfile)             | 16 MB    |

## Usage

### Prerequisites

* [docker](https://www.docker.com/) is installed;

### Instructions

Execute:

    $ ./build.sh
    $ docker run -p 80:80 microcontainer

...it's possible to override tag, for example:

    $ ./build.sh helloworld
    $ docker run -p 80:80 helloworld

