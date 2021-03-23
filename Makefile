help:
	@echo "linter-fix		solve simple linter porblems like fmt"
	@echo "linter-get		install golangcli-linter"
	@echo "lint				run golangcli-linter"
	@echo "dependencies		install development dependencies"
	@echo "test				run tests and create coverage and report"

linter-get:
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s v1.36.0

lint:
	$(GO_VARS) ./bin/golangci-lint run --timeout 10m

lint-fix:
	# run goimports for all files
	find . -name \*.go  -exec goimports -w {} \;

dependencies:
	go mod download

test: */*/*.go
	$(GO_VARS) $(GO) test $(GO_PACKAGES)  \
	-cover -coverpkg=./... -coverprofile=.test.profile.cov -timeout 1m -v -failfast && \
	echo -e "\nTesting is passed." && \
	$(GO_VARS) $(GO) tool cover -func .test.profile.cov && \
	$(GO) tool cover -html=.test.profile.cov -o coverage.html

### COMMON VARIABLES ###
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S), Linux)
	OS ?= linux
endif
ifeq ($(UNAME_S), Darwin)
	OS ?= osx
endif
ARCH := $(shell uname -m)
ifeq ($(ARCH), unknown)
	ARCH := x86_64
endif
ifeq ($(ARCH), i386)
	ARCH = x86_32
endif

GO_VARS ?=
GO_PACKAGES := $(shell go list ./... | grep -v /examples/ | grep -v /internal/testutil/)
GO ?= CGO_ENABLED=0 go
GIT ?= git
COMMIT := $(shell $(GIT) rev-parse HEAD)
VERSION ?= $(shell $(GIT) describe --tags ${COMMIT} 2> /dev/null || echo "$(COMMIT)")
