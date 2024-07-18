# use the official rust image as a base image
from rust:latest

# create a new empty shell project
workdir /chatwave_api

# copy the cargo.toml and cargo.lock files
copy Cargo.toml Cargo.lock ./

# build the application in release mode
run cargo run

# run the application
cmd ["cargo","run","build"]
