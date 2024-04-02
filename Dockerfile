FROM golang as builder
WORKDIR /build
COPY . .

RUN go build

FROM debian
WORKDIR /app
RUN apt update && apt-get install ca-certificates -y

COPY --from=builder /build/ethexporter /usr/bin/
ENV GETH https://mainnet.infura.io
ENV PORT 9015

ADD addresses.txt /app

EXPOSE 9015

ENTRYPOINT /usr/bin/ethexporter
