# sui-node-docker

## build docker file
```sh
docker build . -t sui-devtest:0.6.0
docker tag sui-devtest:0.6.0 duonghuynhbaocr/sui-devtest-arm64:0.6.0
docker push duonghuynhbaocr/sui-devtest-arm64:0.6.0
```

## run docker-compose from images on docker hub

```sh
docker compose -f ./docker-compose.yaml up -d
```

