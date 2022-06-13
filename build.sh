#!/bin/bash -le

gis_versions=(
  3.0.5
  3.1.5
  3.2.1
)

images=(
  postgres:12-alpine
  postgres:13-alpine
  postgres:14-alpine
)

repository=${REPOSITORY:-mjquinlan2000/postgis}
platforms=${PLATFORMS:-linux/amd64,linux/arm64}

for image in ${images[@]}; do
  for version in ${gis_versions[@]}; do
    if [[ $version = "3.0.5" ]] && [[ $image = "postgres:14-alpine" ]]; then continue; fi
    tag=`echo $image | sed s/:/-/g`-postgis-$version

    echo "Starting build..."
    echo "IMAGE: $image"
    echo "POSTGIS VERSION: $version"
    echo "PLATFORM: $platform"
    echo "IMAGE NAME: $image_name"
    echo "TAG: $tag"

    docker buildx build --platform $platforms --pull \
      --build-arg POSTGIS_VERSION=$version \
      --build-arg BUILD_IMAGE=$image \
      -t $repository:$tag \
      --push .

    echo "Done!"
  done
done
