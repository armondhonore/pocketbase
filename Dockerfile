FROM mirror.gcr.io/library/golang:1.25-alpine AS builder
RUN apk add --no-cache gcc musl-dev
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o /app/pocketbase .

FROM mirror.gcr.io/library/alpine:3.20
RUN apk add --no-cache ca-certificates tini
COPY --from=builder /app/pocketbase /app/pocketbase
EXPOSE 8090
ENTRYPOINT ["/sbin/tini", "--", "/app/pocketbase", "serve", "--http=0.0.0.0:8090"]
