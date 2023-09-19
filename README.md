# spacemesh-docker

spacemesh docker

### 第一次运行

docker compose up -d

或者使用B, C方法

### 1. 更新: 重新构建镜像, 自动获取最新版本重新构建

#### 方法A: 下载代码编译，需要时间较长
docker build . --tag spacemesh --no-cache

docker compose up -d

#### 方法B: 下载官方编译的文件
x86

docker build . -f ./Dockerfile.release --tag spacemesh --no-cache

arm

docker build . -f ./Dockerfile.release --tag spacemesh --build-arg ARM=yes --no-cache

运行

docker compose up -d

#### 方法C: 使用本地下载的官方编译的文件, 下载文件到当前目录，https://github.com/spacemeshos/go-spacemesh/releases

arm版本需要把名字改为Linux.zip

docker build . -f ./Dockerfile.copy --tag spacemesh --no-cache

运行

docker compose up -d

#### smeshing-opts-proving-threads可以根据实际情况修改，看数据大小和本身cpu。需要保证在12小时内验证一遍。
```
"smeshing-proving-opts": {
  "smeshing-opts-proving-nonces": 288,
  "smeshing-opts-proving-threads": 6
}
```

### 2.使用grpcurl查看rpc接口的状态, 主要是查自己哪些layer会收到奖励，执行内置check.sh

`docker compose exec -it spacemesh /app/go-spacemesh/check.sh`

### 3.查看版本

`docker compose exec spacemesh /app/go-spacemesh/go-spacemesh version`


### 4.停止运行

docker compose down

### 4.启动

docker compose up -d