# ss-port-mapping
A reliable way to map your shadowsocks' tcp &amp; udp port to your local machine.

## client build

docker buildx build --platform linux/arm/v7,linux/arm64,linux/386,linux/amd64 -t [image tag] .

## server build
docker build -t [image tag] .
