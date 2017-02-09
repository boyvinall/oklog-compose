FROM alpine
ADD oklog /
ENTRYPOINT ["/oklog"]