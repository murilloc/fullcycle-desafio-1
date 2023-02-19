FROM golang:1.20 AS builder

WORKDIR /app

RUN apt update
RUN apt install -y upx

RUN go mod init fullcycle

COPY hello.go .

RUN go build -ldflags "-w" hello.go

RUN upx hello


FROM busybox:musl
WORKDIR /app
COPY --from=builder /app/hello .
CMD [ "./hello" ]


