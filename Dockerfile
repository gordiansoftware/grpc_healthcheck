FROM public.ecr.aws/docker/library/golang:1.26.1-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 go build -o grpc_healthcheck .

FROM scratch
COPY --from=builder /app/grpc_healthcheck /grpc_healthcheck
ENTRYPOINT ["/grpc_healthcheck"]
