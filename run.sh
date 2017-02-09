#!/bin/sh

exec /oklog $OKLOG_COMMAND \
    -api=$OKLOG_API \
    -ingest.fast=$OKLOG_INGEST_FAST \
    -ingest.durable=$OKLOG_INGEST_DURABLE \
    -ingest.bulk=$OKLOG_INGEST_BULK \
    -cluster=$OKLOG_CLUSTER \
    -store.segment-target-size=$OKLOG_STORE_SEGMENT_TARGET_SIZE \
    -store.segment-retain=$OKLOG_STORE_SEGMENT_RETAIN \
    -store.segment-purge=$OKLOG_STORE_SEGMENT_PURGE \
    -ingest.path=$OKLOG_INGEST_PATH \
    -store.path=$OKLOG_STORE_PATH \
    "$@"