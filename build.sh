#!/bin/bash -le

gis_versions=(
  3.0.8
  3.1.5
  3.1.8
  3.2.4
  3.3.2
)

images=(
  postgres:12-alpine
  postgres:13-alpine
  postgres:14-alpine
)

repository=${REPOSITORY:-mjquinlan2000/postgis}
platforms=${PLATFORMS:-linux/amd64,linux/arm64}

echo "Pushing all images to $repository"
echo "Building for platform(s) $platforms"

for image in ${images[@]}; do
  for version in ${gis_versions[@]}; do
    if [[ $version = "3.0.8" ]] && [[ $image = "postgres:14-alpine" ]]; then continue; fi
    tag=`echo $image | sed s/:/-/g`-postgis-$version

    echo "Starting build..."
    echo "IMAGE: $image"
    echo "POSTGIS VERSION: $version"
    echo "TAG: $tag"

    docker buildx build --platform $platforms --pull \
      --build-arg POSTGIS_VERSION=$version \
      --build-arg BUILD_IMAGE=$image \
      -t $repository:$tag \
      --push .

    echo "Done!"
  done
done
