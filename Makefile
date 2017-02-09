.PHONY: all
all: compose-up

# you need to build with go 1.8, which might not be your default
GO?=go

oklog:
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
clobber:
	docker-compose down -v