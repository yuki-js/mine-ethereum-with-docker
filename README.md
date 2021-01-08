# Mine Ethereum with Docker

## Build

Build `ethminer` binary while building image

```sh
docker build -t ethminer:latest .
```

## Run 

By default, shares are sent to my account. 

```sh
docker run --rm -d --name ethminer --gpus all ethminer:latest
```
