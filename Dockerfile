FROM mirror.gcr.io/library/golang:1.25-alpine AS builder
RUN apk add --no-cache gcc musl-dev
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
# The repo root is the PocketBase *library* (package pocketbase); the runnable
# server is the main package in examples/base. Building "." produced a non-exec
# library object at /app/pocketbase (exec ... Permission denied / exit 126).
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o /app/pocketbase ./examples/base

FROM mirror.gcr.io/library/alpine:3.20
RUN apk add --no-cache ca-certificates tini
COPY --from=builder /app/pocketbase /app/pocketbase
RUN mkdir -p /pb/pb_data
EXPOSE 8090
# Bind all interfaces on 8090 and persist data under the mounted volume.
ENTRYPOINT ["/sbin/tini", "--", "/app/pocketbase", "serve", "--http=0.0.0.0:8090", "--dir=/pb/pb_data"]
