FROM golang:alpine3.12

ENV GODEBUG=netdns=go

ADD release/tcellexample /bin/

ENTRYPOINT [ "/bin/tcellexample"]