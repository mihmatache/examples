FROM golang:alpine as build
RUN apk --no-cache add git
ENV PACKAGEPATH=github.com/networkservicemesh/networkservicemesh/
ENV GO111MODULE=on

RUN mkdir /root/networkservicemesh
ADD ["go.mod","/root/networkservicemesh"]
WORKDIR /root/networkservicemesh/
RUN go mod download

ADD [".","/root/networkservicemesh"]
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags '-extldflags "-static"' -o /go/bin/sidecar-nse ./examples/proxy/sidecar-nse/cmd/main.go
FROM alpine as runtime
COPY --from=build /go/bin/sidecar-nse /bin/sidecar-nse
ENTRYPOINT ["/bin/sidecar-nse"]
