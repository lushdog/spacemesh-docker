# spacemesh-docker

spacemesh docker

### 第一次运行

docker compose up -d

### 更新: 修改 docker-compose.yml 里的版本, 然后重新构建镜像

docker compose up -d --build

### 不重新构建镜像，只重新构建容器

docker compose down

docker compose up -d
