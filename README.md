# oklog-compose

This is a simple test setup to experiment with [github.com/oklog/oklog](https://github.com/oklog/oklog).

This needs to be built with go1.8.  If you don't have that already, then follow
the instructions at [https://golang.org/dl/](https://golang.org/dl/).

To build this, you can just type `make` to build it - or, if you're using `go get`
to grab the latest golang release, something like this:

    # make GO=go1.8rc3
    CGO_ENABLED=0 go1.8rc3 build -ldflags="-s -w" github.com/oklog/oklog/cmd/oklog
    docker build -t oklog .
    Sending build context to Docker daemon 9.252 MB
    Step 1 : FROM alpine
     ---> 88e169ea8f46
    Step 2 : ADD oklog run.sh /
     ---> d7cc2a23f13a
    Removing intermediate container 984441cc54f1
    Step 3 : ENV OKLOG_COMMAND ingeststore OKLOG_API tcp://0.0.0.0:10000 OKLOG_INGEST_FAST tcp://0.0.0.0:10001 OKLOG_INGEST_DURABLE tcp://0.0.0.0:10002 OKLOG_INGEST_BULK tcp://0.0.0.0:10003 OKLOG_CLUSTER tcp://0.0.0.0:10009 OKLOG_STORE_SEGMENT_TARGET_SIZE 1000000 OKLOG_STORE_SEGMENT_RETAIN 30m     OKLOG_STORE_SEGMENT_PURGE 5m OKLOG_INGEST_PATH /data/ingest OKLOG_STORE_PATH /data/store
     ---> Running in bb94eb6a71c1
     ---> 57a5d36c005d
    Removing intermediate container bb94eb6a71c1
    Step 4 : ENTRYPOINT /run.sh
     ---> Running in 5bce300374a4
     ---> 4418e376e544
    Removing intermediate container 5bce300374a4
    Successfully built 4418e376e544
    docker-compose up -d
    Creating network "oklog_default" with the default driver
    Creating volume "oklog_data1" with default driver
    Creating volume "oklog_data3" with default driver
    Creating volume "oklog_data2" with default driver
    Creating oklog_logspout_1
    Creating oklog3
    Creating oklog1
    Creating oklog2

If you have a `GOPATH` setup then that should be respected, otherwise the makefile
will set it underneath this repo.

The compose stack here has a logspout container running to grab docker logs on this machine.
You can use this to get some logs into oklog by running the following:

    docker run --rm ubuntu:latest bash -c 'for i in {1..10}; do date; sleep 1; done'

Then you can query for the logs as follows:

    ./oklog query --store localhost:10010

