VERSION := $(VERSION)
ifeq ($(REGISTRY),)
        REGISTRY := celsosantos
endif

ifeq ($(PREFIX),)
        PREFIX := /usr/glibc-compat
endif

.PHONY: glibc-builder
glibc-builder:
	docker build -f Dockerfile-glibc-builder -t $(REGISTRY)/glibc-builder:$(VERSION) .

.PHONY: release-builder
release-builder:
	docker push $(REGISTRY)/glibc-builder:$(VERSION)

.PHONY: glibc
glibc:
	docker run --rm --env STDOUT=1 $(REGISTRY)/glibc-builder:$(VERSION) $(VERSION) $(PREFIX) > glibc-bin.tar.gz

.PHONY: alpine
alpine:
	docker build -f Dockerfile-alpine-glibc -t $(REGISTRY)/alpine-glibc:$(VERSION) .

.PHONY: release-alpine
release-alpine:
	make glibc
	make alpine
	docker push -t $(REGISTRY)/alpine-glibc:$(VERSION)