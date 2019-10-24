# compile env
FROM golang:1.12
#ENV GOPROXY=https://athens.i.ddex.io

WORKDIR /app
COPY . /app
RUN go mod download
RUN go build -ldflags "-w -linkmode external -extldflags -static" -v -o main

FROM alpine
RUN apk --no-cache add ca-certificates
COPY --from=0 /app/main /bin/main