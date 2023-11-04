FROM alpine:latest
COPY src /home/src
COPY Cargo.toml /home/Cargo.toml
COPY model /home/model
RUN apk add --no-cache rust cargo openssl-dev
WORKDIR /home
RUN ["cargo", "build", "--release"]
ENTRYPOINT ["cargo", "run", "--release"]
# CMD ["/bin/bash", "-c", "cd /home && cargo run"]
# RUN cargo build --release