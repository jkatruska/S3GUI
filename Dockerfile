FROM golang:1.17-alpine
RUN go install github.com/cespare/reflex@latest

# Create appuser.
RUN adduser -D -g '' appuser
RUN mkdir -p /go/src/app

WORKDIR /go/src/app

COPY . /go/src/app
CMD reflex -r '\.go$$' -R '_gen\.go$$|_test\.go$$' -R '^vendor/' -s -- sh -c 'go run main.go'

RUN go build -o /go/bin/app

EXPOSE 8080

CMD ["/go/bin/app"]