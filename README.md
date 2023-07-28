# Etcd UI

A modern and easy to use Client/UI for `Etcd`
A configuration center based on `Etcd`

![ui](https://github.com/cruvie/kk_etcd_ui/blob/master/lib/assets/images/ui.png?raw=true) 

## How to use

You need to run the [server](https://github.com/cruvie/kk_etcd_go) first, then you can use the [client](https://github.com/cruvie/kk_etcd_ui) to connect to the server.

Yes, you need to use them together.

## Note

We recommend that the client and server use the same version(they will be updated together, and incompatible versions
may make
some unexpected errors).

# Client

[Homepage Client](https://github.com/cruvie/kk_etcd_ui)

[Download](https://github.com/cruvie/kk_etcd_ui/releases)

| Windows                   | MacOS                                       | Linux                     | Web | Docker |
|---------------------------|---------------------------------------------|---------------------------|-----|--------| 
| ✅                         | ✅                                           | ✅                         | ✅   | ✅      |
| need to build by yourself | `arm64`✅<br/>`x86`need to build by yourself | need to build by yourself | ✅   | ✅      |

## Docker
change `version` to a specific version on [docker hub](https://hub.docker.com/r/kangxhcmk/kk_etcd_ui/tags)
```shell
docker run --name kk_etcd_ui -p 2334:80 kangxhcmk/kk_etcd_ui:version
```

docker-compose

```yaml
version: "3"

services:
  kk-etcd-ui:
    image: kangxhcmk/kk_etcd_ui:version
    container_name: kk-etcd-ui
    ports:
      - "2334:80"
    restart: unless-stopped

```
http://localhost:2334

# Server

[Homepage Server](https://github.com/cruvie/kk_etcd_go)

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
# SDK
we only provide `go` sdk now
```shell
  go get github.com/cruvie/kk_etcd_go
```
init and get config from etcd

`my_config` in etcd (yaml format)
```yaml
ServerAddr: 127.0.0.1:8759

Postgres:
  Dsn: host=127.0.0.1 user=xxxx password=xxxx dbname=xxxx port=5432 sslmode=disable TimeZone=UTC

Redis:
  Addr: 127.0.0.1:6379
  Password: xxxx

MinIO:
  AccessEndpoint: http://127.0.0.1:9000/
```
get config in your project from etcd
```go

import "github.com/cruvie/kk_etcd_go/kk_etcd"

var GlobalConfig Config

type Config struct {
	ServerAddr string `yaml:"ServerAddr"`
	Postgres struct {
		Dsn string `yaml:"Dsn"`
	} `yaml:"Postgres"`
	Redis struct {
		Addr     string `yaml:"Addr"`
		Password string `yaml:"Password"`
	} `yaml:"Redis"`
	MinIO struct {
		AccessEndpoint string `yaml:"AccessEndpoint"`
	} `yaml:"MinIO"`
}

var (
	endpoints = []string{"http://127.0.0.1:2379"} //http://etcd:2379  http://127.0.0.1:2379
	configKey = "my_config"

	userName = "admin"
	password = "admin"
)

func InitEtcd() {
	kk_etcd.InitEtcd(endpoints, userName, password)
	kk_etcd.GetConfig(configKey, &GlobalConfig)
}
```

# Contribute

Feel free to send pull requests or create issues if you find any bugs or have any suggestions.

# Donate

Buy me a cup of coffee ☕️ if you like this project and want to keep it active.

| Alipay                                 | Wechat                                 | Paypal                                 |
|----------------------------------------|----------------------------------------|----------------------------------------|
| ![alipay](https://github.com/cruvie/kk_etcd_ui/blob/master/lib/assets/pay/alipay.png?raw=true) | ![wechat](https://github.com/cruvie/kk_etcd_ui/blob/master/lib/assets/pay/wechat.png?raw=true) | ![wechat](https://github.com/cruvie/kk_etcd_ui/blob/master/lib/assets/pay/wechat.png?raw=true) |
