# PostGIS Docker Images

Provides cross-platform docker builds of [PostGIS](https://postgis.net/). Currently,
the script only uses the alpine base images of the [postgres](https://hub.docker.com/_/postgres)
Docker image.

## Usage

There is only one build script. It uses `docker buildx` to download and compile various
versions of PostGIS. You can modify it to suit your needs.

```bash
./build.sh
```

## Environment Variables

| name       | default                   | description                  |
| ---------- | ------------------------- | ---------------------------- |
| REPOSITORY | "mjquinlan2000/postgis"   | Docker repository to push to |
| PLATFORMS  | "linux/amd64,linux/arm64" | Build targets to use         |

## Images

The images I build can be found here: [mjquinlan2000/postgis](https://hub.docker.com/repository/docker/mjquinlan2000/postgis)

I will try to push them frequently, but there are no guarantees.
