
BINDIR    := $(CURDIR)/bin
PLATFORMS := linux/amd64/rk-Linux-x86_64 darwin/amd64/rk-Darwin-x86_64 windows/amd64/rk.exe linux/arm64/rk-Linux-arm64 darwin/arm64/rk-Darwin-arm64
# dlv exec ./bin/previewd --headless --listen=:2345 --log --api-version=2 -- testserver --loglevel=debug
BUILDCOMMANDDEBUG := go build -gcflags "all=-N -l" -tags "osusergo netgo static_build"
BUILDCOMMAND := go build -trimpath -ldflags "-s -w -X github.com/clarkezone/previewd/pkg/config.VersionHash=${VERSION_HASH} -X github.com/clarkezone/previewd/pkg/config.VersionString=${VERSION_STRING}" -tags "osusergo netgo static_build"
temp = $(subst /, ,$@)
os = $(word 1, $(temp))
arch = $(word 2, $(temp))
label = $(word 3, $(temp))

UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
SHACOMMAND := shasum -a 256
else
SHACOMMAND := sha256sum
endif

.DEFAULT_GOAL := build


.PHONY: integration
integration:
	go test -tags="integration" --count=1 -v -timeout 15m ./pkg/kubelayer/...
#	go test -tags="integration" --count=1 -v -timeout 15m ./pkg/jobmanager/...

# This requires
.PHONY: e2etest
e2etest:
# TODO these need to wait before they can be used in here
	go test -tags="integration" --count=1 -v -timeout 15m ./cmd/ -run TestSetupEnvironment
	go test -tags="integration" --count=1 -v -timeout 15m ./cmd/ -run TestCreateJobForClone
	go test -tags="integration" --count=1 -v -timeout 15m ./cmd/ -run TestFullE2eTestWithWebhook

.PHONY: dep
dep:
	go mod tidy

.PHONY: latest
latest:
	echo ${VERSION_STRING} > bin/latest

.PHONY: lint
lint:
	revive $(shell go list ./...)
	go vet $(shell go list ./...)
	golangci-lint run

.PHONY: precommit
precommit:
	pre-commit run --all-files

.PHONY: build
build:
	$(BUILDCOMMAND) -o ${BINDIR}/previewd

.PHONY: builddlv
builddlv:
	$(BUILDCOMMANDDEBUG) -o ${BINDIR}/previewd

.PHONY: release
build-all: $(PLATFORMS)

$(PLATFORMS):
	GOOS=$(os) GOARCH=$(arch) CGO_ENABLED=0 $(BUILDCOMMAND) -o "bin/$(label)"
	$(SHACOMMAND) "bin/$(label)" > "bin/$(label).sha256"
