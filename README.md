# Satamotodb bitcoin-node image

## Description

**NOTE**: This is not a stand-alone application. It is part of the project [satamotodb](https://github.com/tka85/satamotodb). Check out the (architecture plan)[https://github.com/tka85/satamotodb/architecture.svg] for the various components.

Docker image that contains a bitcoind. It does not have a bitcoin.conf and does not start bitcoind automatically. This is the responsibility of project [satamotodb](https://github.com/tka85/satamotodb) which supplies a bitcoin.conf and actually starts the bitcoind. Check satamotodb's [docker-compose.yml](https://github.com/tka85/satamotodb/blob/master/docker-compose.yml) to see how this image is used.

## Build

```bash
 docker build . -t satamotodb-bitcoin-node
```
