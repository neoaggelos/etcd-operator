FROM golang:1.17 AS builder
LABEL maintainer="Angelos Kolaitis <angelos.kolaitis@canonical.com>"
WORKDIR /src
COPY . /src
RUN \
    CGO_ENABLED=0 \
    go build \
        -a -ldflags "-s -w -extldflags '-static' -X github.com/coreos/etcd-operator/version.GitSHA=`git rev-parse --short HEAD || echo GitNotFound`" \
        -o /operator ./cmd/operator

FROM scratch
COPY --from=builder /operator /operator
CMD ["/operator"]
