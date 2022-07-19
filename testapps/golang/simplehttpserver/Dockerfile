FROM docker.io/golang:alpine as builder
RUN mkdir /build
WORKDIR /build
COPY go.mod .

RUN go mod download
COPY . .
run apk --no-cache add gcc build-base git
run make build

FROM alpine:3.11.3
RUN apk update
RUN apk add git
COPY --from=builder /build/bin/simplehttpserver .

# executable
ENTRYPOINT [ "./simplehttpserver" ]