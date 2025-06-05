FROM golang:1.22 AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main

FROM golang:1.22-alpine
WORKDIR	/app
COPY --from=builder /app/main ./
COPY --from=builder /app/static ./static
EXPOSE 8080
CMD ["./main"]
