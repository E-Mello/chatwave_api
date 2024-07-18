# Use the official Rust image as the base image
FROM rust:1.67 as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Cargo.toml and Cargo.lock files
COPY Cargo.toml Cargo.lock ./

# Copy the source code
COPY src ./src

# Build the project for release
RUN cargo build --release

# Use a smaller base image for the final stage
FROM debian:buster-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the built binary from the builder stage
COPY --from=builder /app/target/release/chatwave_api .

# Expose the port that your app will run on
EXPOSE 8080

# Set the command to run the application
CMD ["./chatwave_api"]
