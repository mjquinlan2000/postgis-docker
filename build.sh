#!/bin/bash -leo pipefail

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

platform=${PLATFORM:-"linux/arm64"}
image_name=${IMAGE_NAME:-"mjquinlan2000/postgis-arm64"}

for image in ${images[@]}; do
  for version in ${gis_versions[@]}; do
    if [[ $version = "3.0.5" ]] && [[ $image = "postgres:14-alpine" ]]; then continue; fi
    default_tag=`echo $image | sed s/:/-/g`-postgis-$version
    tag=${TAG:-$default_tag}

    echo "Starting build..."
    echo "IMAGE: $image"
    echo "POSTGIS VERSION: $version"
    echo "PLATFORM: $platform"
    echo "IMAGE NAME: $image_name"
    echo "TAG: $tag"

    docker build --platform $platform --pull \
      --build-arg VERSION=$version \
      --build-arg IMAGE=$image \
      -t $image_name:$tag .

    if [[ $PUSH = true ]]; then
      echo "Pushing image..."
      docker push $image_name:$tag
    fi

    echo "Done!"
  done
done