# alpine-glibc

This repo contains the code to generate https://hub.docker.com/r/celsosantos/alpine-glibc.
It can produce builds for any architecture. This one is used to produce ARM64 builds.

It also includes a glibc binary package builder in Docker. Produces a glibc binary package that can be imported into a rootfs to run applications dynamically linked against glibc, highly based on https://github.com/sgerrand/docker-glibc-builder

## Usage

To produce an alpine-glibc docker image run the following command:

```bash
make release-alpine
```

If you just want to produce the tarball with the glibc binary, use
(Note: This assumes you already built or pulled $(REGISTRY)/glibc-builder:$(VERSION))

```bash
make glibc
```

### Glibc-Builder

Build a glibc package based on version 2.31 with a prefix of `/usr/glibc-compat`:

    docker run --rm --env STDOUT=1 sgerrand/glibc-builder 2.31 /usr/glibc-compat > glibc-bin.tar.gz

You can also keep the container around and copy out the resulting file:

    docker run --name glibc-binary sgerrand/glibc-builder 2.31 /usr/glibc-compat
    docker cp glibc-binary:/glibc-bin-2.31.tar.gz ./
    docker rm glibc-binary
