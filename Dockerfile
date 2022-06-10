FROM postgres:12-alpine AS builder

RUN apk add --no-cache curl make clang libc-dev gcc perl libxml2-dev geos-dev proj-dev gdal-dev llvm && \
  mkdir -p /source && \
  cd /source && \
  curl -sSL https://download.osgeo.org/postgis/source/postgis-3.0.5.tar.gz | tar xvz && \
  cd postgis-3.0.5 && \
  ./configure && \
  make && \
  make install && \
  cd / && \
  rm -fr /source

FROM postgres:12-alpine

RUN apk add --no-cache libxml2 geos proj gdal

COPY --from=builder /usr/local/share/postgresql /usr/local/share/postgresql
COPY --from=builder /usr/local/lib/postgresql /usr/local/lib/postgresql
COPY --from=builder /usr/local/bin /usr/local/bin
