## Insecure Base Image :Image with vulnerability(Used for building image)
FROM image-registry.openshift-image-registry.svc:5000/openshift/golang:1.16.7-ubi8 as builder

WORKDIR /build
ADD . /build/


RUN mkdir /tmp/cache
RUN CGO_ENABLED=0 GOCACHE=/tmp/cache go build  -mod=vendor -v -o /tmp/api-server .

## Secure Base Image
scratch
## Insecure Base Image :Image with vulnerability
# FROM image-registry.openshift-image-registry.svc:5000/openshift/golang:1.16.7-ubi8

WORKDIR /app
COPY --from=builder /tmp/api-server /app/api-server

CMD [ "/app/api-server" ]
