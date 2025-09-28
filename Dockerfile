FROM golang:1.24-alpine AS builder


WORKDIR /app
COPY go.mod ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o test-app ./main.go


FROM scratch

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /app/test-app /test-app

EXPOSE 8082

ENTRYPOINT ["/test-app"]