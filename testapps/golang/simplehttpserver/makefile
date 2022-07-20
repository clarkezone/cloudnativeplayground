BINDIR    := $(CURDIR)/bin
BUILDCOMMAND := go build -trimpath -ldflags -s -tags "osusergo netgo static_build"

.DEFAULT_GOAL := build

.PHONY: build
build:
	$(BUILDCOMMAND) -o ${BINDIR}/simplehttpserver

.PHONY: podmanbuild
podmanbuild:
	podman build . -t hellogolang

.PHONY: dockerbuild
dockerbuild:
	docker build . -t hellogolang
