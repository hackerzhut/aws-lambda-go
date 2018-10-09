FROM golang:1.10.2-alpine
RUN go version

WORKDIR /go/src/app
COPY . /go/src/app/

RUN apk add --no-cache git bash && \
    go get -u github.com/golang/dep/cmd/dep && \
    go get -u github.com/golang/lint/golint && \
    dep ensure -v

RUN CGO_ENABLED=0 GOOS=linux go build -v -a -installsuffix cgo -o ./vehicle ./src/handlers/vehicle.go
