#https://github.com/MystenLabs/sui/blob/main/doc/src/build/fullnode.md#building-from-source

FROM rust:buster as BUILDER

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y --no-install-recommends \
    tzdata \
    git \
    ca-certificates \
    curl \
    build-essential \
    libssl-dev \
    pkg-config \
    libclang-dev \
    llvm clang \
    cmake &&\
    rustup update stable

#RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

#RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc
# Add .cargo/bin to PATH
#ENV PATH="$HOME/.cargo/bin:${PATH}"


WORKDIR /src
RUN git clone https://github.com/MystenLabs/sui.git &&\
   cd  sui &&\
   git checkout tags/devnet-0.6.0 &&\
   cargo build --release


FROM rust:slim-buster as RUNER
WORKDIR /sui
COPY --from=BUILDER /src/sui/target/release/sui-cluster-test \
                    /src/sui/target/release/remote_load_generator \
                    /src/sui/target/release/sui \
                    /src/sui/target/release/libsui_open_rpc_macros.so \
                    /src/sui/target/release/sui-node \
                    /src/sui/target/release/x \
                    /src/sui/target/release/bench_configure \
                    /src/sui/target/release/rpc-server \
                    /src/sui/target/release/shared \
                    /src/sui/target/release/bench \
                    /src/sui/target/release/sui-faucet   /sui/
#COPY --from=BUILDER /src/sui/target/release /sui/
