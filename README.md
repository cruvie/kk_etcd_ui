# Etcd UI

A modern and easy to use Client/UI for `Etcd`

A Configuration center and Service registration and discovery platform based on `Etcd`

![ui](https://github.com/cruvie/kk_etcd_ui/blob/master/lib/assets/images/ui.png?raw=true)

![ui](https://github.com/cruvie/kk_etcd_ui/blob/master/lib/assets/images/ui2.png?raw=true)

# How to use?🤔

download [example](https://github.com/cruvie/kk_etcd_go/tree/master/example)

```shell
cd example
docker-compose up
```

you can change `version` to a specific version on [docker hub](https://hub.docker.com/r/cruvie/kk_etcd_ui/tags)

# Warning ❗

Make sure the client and server use the same version, they will be updated together, incompatible versions
may make some unexpected errors.

# Client

[Homepage Client](https://github.com/cruvie/kk_etcd_ui)

[Download](https://github.com/cruvie/kk_etcd_ui/releases)

| Windows/MacOS/Linux | Web               | Docker |
|---------------------|-------------------|--------| 
| ✅                   | ✅                 | ✅      |
| build from source   | build from source | ✅      |

then visit http://localhost:2334

## Server

[Homepage Server](https://github.com/cruvie/kk_etcd_go)


# SDK

```shell
  go get github.com/cruvie/kk_etcd_go@latest
```

## Put/Get config into/from etcd in yaml/json format

assume you have a config file like this

```yaml
ServerAddr: 127.0.0.1:8759

Postgres:
  Dsn: host=127.0.0.1 user=xxxx password=xxxx dbname=xxxx port=5432 sslmode=disable TimeZone=UTC

Redis:
  Addr: 127.0.0.1:6379
  Password: xxxx
```

put/get it to/from etcd with key `my_config`

```go
package doc_test

import (
	"github.com/cruvie/kk_etcd_go/kk_etcd"
	"gopkg.in/yaml.v3"
	"log"
	"log/slog"
	"os"
	"testing"
)

type myConfig struct {
	ServerAddr string
	Postgres   struct {
		Dsn  string
		Port int
	}
	Redis struct {
		Addr     string
		Password string
	}
}

func TestPutYaml(t *testing.T) {
	//init client
	closeFunc, err := kk_etcd.InitClient(&kk_etcd.InitClientConfig{
		Endpoints: []string{"http://127.0.0.1:2379"},
		UserName:  "root",
		Password:  "root",
		DebugMode: true})
	if err != nil {
		panic(err)
	}
	defer func() {
		err := closeFunc()
		if err != nil {
			log.Println(err)
		}
	}()
	//load config
	data, err := os.ReadFile("path/to/my_config.yml")
	if err != nil {
		panic(err)
	}
	var Config myConfig
	err = yaml.Unmarshal(data, &Config)
	if err != nil {
		slog.Error("unable to unmarshal config.yaml", "err", err)
		panic(err)
	}
	//push config to etcd in yaml format
	err = kk_etcd.PutExistUpdateYaml("my_config", &Config)
	if err != nil {
		panic(err)
	}
	//get config from etcd
	var newConfig myConfig
	err = kk_etcd.GetYaml("my_config", &newConfig)
	if err != nil {
		panic(err)
	}
}
```

## Register Http/gRPC Server to etcd
refers to [Register Http Server](https://github.com/cruvie/kk_etcd_go/blob/566e340dee0ca3b38bff574fe223887035fe67d6/kk_etcd/server_test.go#L105)

refers to [Register Grpc Server](https://github.com/cruvie/kk_etcd_go/blob/566e340dee0ca3b38bff574fe223887035fe67d6/kk_etcd/server_test.go#L51)


## Get a grpc client from etcd
refers to [GetGrpcClient](https://github.com/cruvie/kk_etcd_go/blob/566e340dee0ca3b38bff574fe223887035fe67d6/kk_etcd/server_grpc.go#L14)

# Contribute

Feel free to send pull requests or fire issues
if you encounter any bugs or have suggestions.

# Donate

Buy me a cup of coffee ☕️ if you like this project and want to keep it active.

| Alipay                                                                                         | Wechat                                                                                         |
|------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------|
| ![alipay](https://github.com/cruvie/kk_etcd_ui/blob/master/lib/assets/pay/alipay.png?raw=true) | ![wechat](https://github.com/cruvie/kk_etcd_ui/blob/master/lib/assets/pay/wechat.png?raw=true) | 
