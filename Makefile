.PHONY: all
all: compose-up

# you need to build with go 1.8, which might not be your default
GO?=go

ifeq ($(GOPATH),)
GOPATH=$(shell pwd)/gocode
endif

export GOPATH

$(GOPATH):
	mkdir -p $@

$(GOPATH)/src/github.com/oklog/oklog/cmd/oklog: $(GOPATH)
	$(GO) get -d -u github.com/oklog/oklog/cmd/oklog

oklog: $(GOPATH)/src/github.com/oklog/oklog/cmd/oklog
	CGO_ENABLED=0 $(GO) build -ldflags="-s -w" github.com/oklog/oklog/cmd/oklog

.PHONY: compose-up
compose-up: image
	docker-compose up -d

.PHONY: image
image: oklog
	docker build -t oklog .

.PHONY: clean
clean:
	$(GO) clean
	rm -f oklog

.PHONY: clobber
clobber: clean
	docker-compose down -v
	docker rmi oklog