ARG IMAGE=postgres:12-alpine

FROM $IMAGE AS builder

ARG VERSION=3.0.5

RUN apk add --no-cache curl make clang libc-dev gcc perl libxml2-dev geos-dev proj-dev gdal-dev llvm protobuf-c-dev g++ && \
  # Fetch postgis
  mkdir -p /tmp/src && \
  cd /tmp/src && \
  curl -sSL https://download.osgeo.org/postgis/source/postgis-$VERSION.tar.gz | tar xvz && \
  cd postgis-$VERSION && \
  # Compile
  ./configure && \
  make && \
  make install && \
  # Cleanup
  cd / && \
  rm -fr /tmp/src && \
  apk del --purge make clang libc-dev gcc perl libxml2-dev geos-dev proj-dev gdal-dev llvm protobuf-c-dev g++ && \
  apk add --no-cache libxml2 geos proj gdal json-c protobuf-c
