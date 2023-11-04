# -----------------
# Cargo Build Stage
# -----------------
FROM rust:latest as cargo-build
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
COPY src /home/src
COPY Cargo.toml /home/Cargo.toml
COPY model /home/model
WORKDIR /home
RUN cargo build --release && cp target/release/ddddocr /home \
&& cp ./target/release/build/onnxruntime-sys-*/out/onnxruntime/onnxruntime-linux-x64-1.8.1/lib/libonnxruntime.so.* /home \
&& rm -rf Cargo.* src target
# -----------------
# Final Stage
# -----------------
FROM ubuntu:22.04

COPY --from=cargo-build /home /home
EXPOSE 9898
ENTRYPOINT ["sh", "-c", "cd /home && LD_LIBRARY_PATH=/home/ ./ddddocr -a 0.0.0.0 --ocr"]