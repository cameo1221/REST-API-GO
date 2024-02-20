FROM golang:1.22.0-alpine3.12 as builder

COPY go.mod go.sum /Documents/TODO_GO/github.com/cameo1221/TODO_GO/
WORKDIR  /Documents/TODO_GO/github.com/cameo1221/TODO_GO/
RUN go mod download
COPY .  /Documents/TODO_GO/github.com/cameo1221/TODO_GO/
RUN SET CGO_ENABLED=0 GOOS=windows go build -a -installsuffix cgo -o build/TODO_GO github.com/cameo1221/TODO_GO


FROM alpine

RUN apk add --no-cache ca-certificates && update-ca-certificates
COPY --from=builder  /Documents/TODO_GO/github.com/cameo1221/TODO_GO//build/TODO_GO /usr/bin/TODO_GO

EXPOSE 8080 8080

ENTRYPOINT ["/usr/bin/TODO_GO"]
