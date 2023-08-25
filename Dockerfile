ARG VERSION="v1.1.1"

FROM golang:1.20
RUN apt update && apt install -y \
    git \
    git-lfs \
    make \
    curl \
    build-essential \
    unzip \
    wget \
    ocl-icd-opencl-dev \
    ocl-icd-libopencl1
RUN git-lfs install
WORKDIR /container
RUN git clone --progress --verbose https://github.com/spacemeshos/go-spacemesh
WORKDIR /container/go-spacemesh
RUN git checkout $VERSION
RUN make get-libs
RUN make install
RUN make build
WORKDIR /container/go-spacemesh/build
RUN wget https://configs.spacemesh.network/config.mainnet.json
RUN chmod +x go-spacemesh
EXPOSE 7513
CMD ./go-spacemesh --config config.mainnet.json --smeshing-opts-provider 4294967295 --smeshing-opts-maxfilesize $FILE_SIZE --smeshing-opts-numunits $NUMUNITS --smeshing-start --smeshing-coinbase $SMESHING_COINBASE_ADDRESS --smeshing-opts-datadir ./post_data --data-folder ./node_data
