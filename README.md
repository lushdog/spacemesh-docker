# spacemesh-docker

spacemesh docker

### 第一次运行

docker compose up -d

### 更新: 重新构建镜像, 自动获取最新版本重新构建

#### A: 下载代码编译，需要时间较长
docker build . --tag spacemesh --no-cache

docker compose up -d

#### B: 下载官方编译的文件
x86
docker build . -f ./Dockerfile.release --tag spacemesh --no-cache

arm
docker build . -f ./Dockerfile.release --tag spacemesh --build-arg ARM=yes --no-cache

docker compose up -d

#### C: 使用本地下载的官方编译的文件, arm版本需要把名字改为Linux.zip
docker build . -f ./Dockerfile.copy --tag spacemesh --no-cache

docker compose up -d

### 不重新构建镜像，只重新构建容器

docker compose down

docker compose up -d

### smeshing-opts-proving-threads可以根据实际情况修改，看数据大小和本身cpu。需要保证在12小时内验证一遍。
```
"smeshing-proving-opts": {
  "smeshing-opts-proving-nonces": 288,
  "smeshing-opts-proving-threads": 6
}
```

