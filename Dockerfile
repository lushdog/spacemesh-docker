# 构建阶段
FROM golang:1.20 AS builder

ARG VERSION

RUN apt update && apt install -y \
    git git-lfs make curl jq build-essential unzip wget ocl-icd-opencl-dev ocl-icd-libopencl1 \
    && git-lfs install

WORKDIR /container/go-spacemesh

RUN VERSION=$(curl -s "https://api.github.com/repos/spacemeshos/go-spacemesh/releases/latest" | jq -r ".tag_name") && echo $VERSION > /version.txt

RUN git clone --progress --verbose https://github.com/spacemeshos/go-spacemesh . \
    && /bin/bash -c "git checkout $(cat /version.txt)" \
    && make get-libs && make install && make build \
    && chmod +x build/go-spacemesh

# 运行阶段
FROM debian:bookworm-slim

COPY --from=builder /container/go-spacemesh/build /app/go-spacemesh

COPY --from=builder /version.txt /app/go-spacemesh


RUN apt update && apt install -y ocl-icd-libopencl1 && rm -rf /var/lib/apt/lists/*

WORKDIR /app/go-spacemesh

COPY config.mainnet.json .

EXPOSE 7513

CMD ./go-spacemesh --config config.mainnet.json --smeshing-opts-maxfilesize $FILE_SIZE --smeshing-opts-numunits $NUMUNITS --smeshing-start --smeshing-coinbase $SMESHING_COINBASE_ADDRESS --smeshing-opts-datadir ./post_data --data-folder ./node_data
