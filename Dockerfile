FROM ubuntu:22.04
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
COPY src /home/src
COPY Cargo.toml /home/Cargo.toml
COPY model /home/model
RUN apt update && apt install -y curl build-essential pkg-config libssl-dev && curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh -s -- -y
WORKDIR /home
RUN source "$HOME/.cargo/env" && cargo build --release
EXPOSE 9898
ENTRYPOINT ["sh", "-c", "source \"$HOME/.cargo/env\" && cargo run --release -- --ocr"]