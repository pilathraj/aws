ZIP_CMD ?= $$GOPATH/bin/build-lambda-zip -o
PYTHON_CMD ?= python
DIRS =$(shell find src/lambdas/* -type d)

#ifndef GOPATH:
#$(error "Pre-requisite '$$GOPATH' not found, Please set your GOPATH as https://github.com/golang/go/wiki/GOPATH")
#endif

.PHONY: all
all: clean install vet lint test build-lambdas

.PHONY: clean
clean:
	rm -rf build

.PHONY: install
install:
	go get ./...

.PHONY: vet
vet:
	go vet -v $(shell go list ./...)

.PHONY: lint
lint:
	golint -set_exit_status $(shell go list ./...)

.PHONY: test
test:
	go test ./...

.PHONY: build-lambdas $(DIRS)
build-lambdas: $(DIRS)

$(DIRS):
	echo $@ && cd $@ && GOOS=linux go build -o main ./...
	cd $@ && ${ZIP_CMD}	handler.zip ./main
