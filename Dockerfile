# use the official rust image as a base image
from rust:1.60 as builder

# create a new empty shell project
run user=root cargo new --bin myapp
workdir /myapp

# copy the cargo.toml and cargo.lock files
copy cargo.toml cargo.lock ./

# copy the source code from the github repository
arg main_rs_url=https://raw.githubusercontent.com/E-Mello/chatwave_api/main/src/main.rs
run curl -o src/main.rs $main_rs_url

# build the application in release mode
run cargo build --release

# create a smaller image to copy the binary
from debian:buster-slim
copy --from=builder /myapp/target/release/myapp /usr/local/bin/myapp

# expose the port that the application will run on
expose 8080

# run the application
cmd ["./target/debug/chatwave_api"]
