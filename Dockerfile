ARG BUILD_IMAGE
FROM $BUILD_IMAGE AS builder

ARG POSTGIS_VERSION=3.0.5

RUN apk add --no-cache curl make clang16 clang15 libc-dev gcc perl libxml2-dev geos-dev proj-dev gdal-dev llvm15 llvm16 protobuf-c-dev g++ && \
  # Fetch postgis
  mkdir -p /tmp/src && \
  cd /tmp/src && \
  curl -sSL https://download.osgeo.org/postgis/source/postgis-$POSTGIS_VERSION.tar.gz | tar xvz && \
  cd postgis-$POSTGIS_VERSION && \
  # Compile
  ./configure && \
  make && \
  make install && \
  # Cleanup
  cd / && \
  rm -fr /tmp/src && \
  apk del --purge make clang16 clang15 libc-dev gcc perl libxml2-dev geos-dev proj-dev gdal-dev llvm15 llvm16 protobuf-c-dev g++ && \
  apk add --no-cache libxml2 geos proj gdal json-c protobuf-c
