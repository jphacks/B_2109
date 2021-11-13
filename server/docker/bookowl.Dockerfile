ARG REPO_NAME="bookowl"
ARG APP_NAME="bookowl"

FROM golang:1.17 as build
ARG REPO_NAME
ARG APP_NAME
COPY . /go/src/${REPO_NAME}
WORKDIR /go/src/${REPO_NAME}
RUN go build -o /go/bin/${APP_NAME}

FROM ubuntu:focal
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
ARG APP_NAME
COPY --from=build /go/bin/${APP_NAME} /${APP_NAME}
CMD ["/app"]
