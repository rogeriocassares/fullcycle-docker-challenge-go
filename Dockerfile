FROM golang:1.19-rc-alpine3.16

LABEL mantainer="roger10cassares@gmail.com"

WORKDIR /app

COPY main.go .
COPY go.mod .

RUN go build -o /fullcycle-rocks

CMD ["/fullcycle-rocks"]