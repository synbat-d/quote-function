FROM ghcr.io/graalvm/native-image-community:17 AS builder
WORKDIR /app
RUN microdnf install -y findutils
COPY . .
RUN chmod +x gradlew && ./gradlew nativeCompile --no-daemon

FROM ubuntu:22.04
WORKDIR /app
COPY --from=builder /app/build/native/nativeCompile/quote-function .
EXPOSE 9101
ENTRYPOINT ["./quote-function"]