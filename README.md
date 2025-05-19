# Etcd UI

[![Go Reference](https://pkg.go.dev/badge/github.com/cruvie/kk_etcd_go.svg)](https://pkg.go.dev/github.com/cruvie/kk_etcd_go)

A modern and easy to use Client/UI for `Etcd`

A Configuration center and Service registration and discovery platform based on `Etcd`

## Feature

- [x] Configuration center

- [x] Service registration and discovery for Http/gRPC Server

- [x] MCP Server

- [x] User management

- [x] Role management

- [ ] AI

## server

![ui](https://github.com/cruvie/kk_etcd_ui/blob/master/lib/assets/images/ui.png?raw=true)

## key value

![ui](https://github.com/cruvie/kk_etcd_ui/blob/master/lib/assets/images/ui2.png?raw=true)

## AI

![ai](https://github.com/cruvie/kk_etcd_ui/blob/master/lib/assets/images/ai.png?raw=true)

# How to use?🤔

download [example](https://github.com/cruvie/kk_etcd_go/tree/master/example)

```shell
cd example
docker-compose up -d
```

you can change `version` to a specific version
on [docker hub](https://hub.docker.com/r/cruvie/kk_etcd_ui/tags)

# Warning ❗

Make sure the client and server use the same version, they will be updated together,
incompatible versions may make some unexpected errors.

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

refers
to [Put/Get](https://github.com/cruvie/kk_etcd_go/blob/566e340dee0ca3b38bff574fe223887035fe67d6/kk_etcd/kv_test.go)

## Register Http/gRPC Server to etcd

refers
to [Register Http Server](https://github.com/cruvie/kk_etcd_go/blob/566e340dee0ca3b38bff574fe223887035fe67d6/kk_etcd/server_test.go)

## Get a grpc client from etcd

refers
to [GetGrpcClient](https://github.com/cruvie/kk_etcd_go/blob/566e340dee0ca3b38bff574fe223887035fe67d6/kk_etcd/server_grpc.go)

# Server Hub Design

## Register a service

```mermaid
sequenceDiagram
    actor Client
    Client ->> SerServer: RegisterService(registration)
    SerServer -->> SerServer: CheckConfig
    SerServer ->> Etcd: Put service info to etcd(kc.Put)
    Etcd -->> ServerHub: Trigger watch event(EventTypePut)
    ServerHub ->> DeadHub: putToDeadHub(registration)
    ServerHub ->> Checker: startNewCheck(registration)
```

## Deregister a service

```mermaid
sequenceDiagram
    actor Client
    Client ->> SerServer: DeregisterServer(registration)
    SerServer ->> Etcd: Delete Service(kc.Delete)
    Etcd -->> ServerHub: Trigger watch event(EventTypeDelete)
    ServerHub ->> DeadHub: delFromDeadHub(registration)
    ServerHub ->> AliveHub: delFromAliveHub(registration)
    ServerHub ->> Checker: stopCheck(registration.Key())
```

## Health check

```mermaid
sequenceDiagram
    ServerHub ->> Checker: startNewCheck(registration)
    loop HealthCheck every service has a health checker with thier own config
        Checker ->> Checker: checkGrpc/checkHttp
        alt if status is healthy and previous status is unhealthy
            Checker ->> ServerHub: update
            ServerHub ->> AliveHub: putToAliveHub(registration)
            ServerHub ->> DeadHub: delFromDeadHub(registration)
            ServerHub ->> Etcd: Put aliveHub to etcd(putHubToEtcd)
        end
    end
```

## Get a grpc connection

```mermaid
sequenceDiagram
    Client ->> SerServer: GetConns(connType, serverName)
    SerServer ->> Etcd: GetAliveHub(getHubFromEtcd)
    SerServer -->> SerServer: Filter connection type(getOneAliveServer)
    loop HealthCheck
        SerServer -->> SerServer: Get one random server (getOneAliveServer)
        SerServer -->> SerServer: Check connection status(checkGrpc)
    end
    SerServer -->> Client: Return grpc client
```

# Contribute

Feel free to send pull requests or fire issues
if you encounter any bugs or have suggestions.

# Donate

Buy me a cup of coffee ☕️ if you like this project and want to keep it active.

| Alipay                                                                                         | Wechat                                                                                         |
|------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------|
| ![alipay](https://github.com/cruvie/kk_etcd_ui/blob/master/lib/assets/pay/alipay.png?raw=true) | ![wechat](https://github.com/cruvie/kk_etcd_ui/blob/master/lib/assets/pay/wechat.png?raw=true) | 

# Thanks

This project is supported by [JetBrains](https://jb.gg/OpenSourceSupport).
![JetBrains logo](https://resources.jetbrains.com/storage/products/company/brand/logos/jetbrains.png)
