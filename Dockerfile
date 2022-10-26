# FROM image-registry.openshift-image-registry.svc:5000/openshift/golang:latest as builder
# FROM docker.io/golang:1.18.7 as builder
FROM image-registry.openshift-image-registry.svc:5000/openshift/golang:1.16.7-ubi8 as builder

WORKDIR /build
ADD . /build/


RUN mkdir /tmp/cache
RUN CGO_ENABLED=0 GOCACHE=/tmp/cache go build  -mod=vendor -v -o /tmp/api-server .

# FROM scratch
FROM image-registry.openshift-image-registry.svc:5000/openshift/golang:1.16.7-ubi8

WORKDIR /app
COPY --from=builder /tmp/api-server /app/api-server

CMD [ "/app/api-server" ]
