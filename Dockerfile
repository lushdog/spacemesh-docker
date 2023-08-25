FROM golang:1.20

ARG VERSION

RUN apt update && apt install -y \
    git git-lfs make curl build-essential unzip wget ocl-icd-opencl-dev ocl-icd-libopencl1 \
    && git-lfs install \
    && git clone --progress --verbose https://github.com/spacemeshos/go-spacemesh /container/go-spacemesh \
    && cd /container/go-spacemesh \
    && git checkout $VERSION \
    && make get-libs && make install && make build \
    && cd /container/go-spacemesh/build \
    && chmod +x go-spacemesh

WORKDIR /container/go-spacemesh/build

COPY config.mainnet.json .

EXPOSE 7513

CMD ./go-spacemesh --config config.mainnet.json --smeshing-opts-maxfilesize $FILE_SIZE --smeshing-opts-numunits $NUMUNITS --smeshing-start --smeshing-coinbase $SMESHING_COINBASE_ADDRESS --smeshing-opts-datadir ./post_data --data-folder ./node_data