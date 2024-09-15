IMAGE?=cdkbot/etcd-operator
VERSION?=$(shell git rev-parse HEAD | head -c 8)

TAG_VERSION=$(IMAGE):$(VERSION)
TAG_LATEST=$(IMAGE):latest

all: etcd-operator

# Build Docker images
build-images: build-image-amd64 build-image-arm64
build-image-%:
	docker build -t ${TAG_VERSION}-$* . --build-arg arch=$*

# Push Docker images
push-images: push-image-amd64 push-image-arm64
push-image-%: build-image-%
	docker image push $(TAG_VERSION)-$*

# Push Docker manifests for multi-arch
manifest: manifest-$(VERSION)
manifest-%: push-images
	docker manifest rm $(IMAGE):$* || true
	docker manifest create $(IMAGE):$* --amend $(TAG_VERSION)-amd64 --amend $(TAG_VERSION)-arm64
	docker manifest annotate $(IMAGE):$* $(TAG_VERSION)-amd64 --arch=amd64
	docker manifest annotate $(IMAGE):$* $(TAG_VERSION)-arm64 --arch=arm64
	docker manifest push $(IMAGE):$*

# Build
etcd-operator: $(shell find . -name "*.go")
	CGO_ENABLED=0 go build -a -ldflags '-extldflags "-static"' -o etcd-operator ./cmd/operator

clean:
	rm etcd-operator

.PHONY: all build-images push-images manifests build-image-* push-image-* manifest-*
