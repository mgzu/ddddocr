FROM ubuntu:22.04
COPY src /home/src
COPY Cargo.toml /home/Cargo.toml
COPY model /home/model
RUN apt update && apt install -y curl && curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh -s -- -y
WORKDIR /home
RUN cargo build --release
ENTRYPOINT ["cargo", "run", "--release"]
# RUN cargo build --release