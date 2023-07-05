# Etcd UI

A modern and easy to use Client/UI for `Etcd`

## How to use

You need to run the [server](https://github.com/gkdgo/kk_etcd_go) first, then you can use the [client](https://github.com/gkdgo/kk_etcd_ui) to connect to the server.

Yes, you need to use them together.

## Note

We recommend that the client and server use the same version(they will be updated together, and incompatible versions
may make
some unexpected errors).

# Client

[Homepage Client](https://github.com/gkdgo/kk_etcd_ui)

| Windows | MacOS | Linux | Web | Docker |
|---------|-------|-------|-----|--------| 
| ✅       | ✅     | ✅     | ✅   | ✅      |
| need to build by yourself      | need to build by yourself     | need to build by yourself     | ✅   | ✅      |

## Docker
change `version` to a specific version on [docker hub](https://hub.docker.com/r/kangxhcmk/kk_etcd_go/tags)
```shell
docker run --name kk_etcd_ui -p 2334:2333 kangxhcmk/kk_etcd_ui:version
```

docker-compose

```yaml
version: "3"

services:
  kk-etcd-ui:
    image: kangxhcmk/kk_etcd_ui:1.0
    container_name: kk-etcd-ui
    ports:
      - "2334:2333"
    restart: unless-stopped

```

# Server

[Homepage Server](https://github.com/gkdgo/kk_etcd_go)

## Docker
change `version` to a specific version on [docker hub](https://hub.docker.com/r/kangxhcmk/kk_etcd_go/tags)
```shell
docker run --name kk_etcd_go -p 2333:2333 -v ./config/config.yml:/kk_etcd_go/config/config.yml kangxhcmk/kk_etcd_go:version
```

docker-compose

```yaml
version: "3"

services:
  kk-etcd-go:
    image: kangxhcmk/kk_etcd_go:version
    container_name: kk-etcd-go
    ports:
      - "2333:2333"
    restart: unless-stopped
    volumes:
      - ./config/config.yml:/kk_etcd_go/config/config.yml

```

# Contribute

Feel free to send pull requests or create issues if you find any bugs or have any suggestions.

# Donate

Buy me a cup of coffee ☕️ if you like this project and want to keep it active.

| Alipay                                 | Wechat                                 | Paypal                                 |
|----------------------------------------|----------------------------------------|----------------------------------------|
| ![alipay](./lib/assets/pay/alipay.png) | ![wechat](./lib/assets/pay/wechat.png) | ![wechat](./lib/assets/pay/wechat.png) |
