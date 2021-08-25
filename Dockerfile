FROM golang:alpine3.12

ENV GODEBUG=netdns=go

ADD release/deepspace /bin/

ENTRYPOINT [ "/bin/deepspace"]