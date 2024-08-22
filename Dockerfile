# Use a base image that is appropriate for your needs
#FROM debian:latest
FROM golang:1.22.1
# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    wget \
    tar \
    build-essential
    
# Set up the working directory
WORKDIR /home/container

# Set TMPDIR to a writable directory and ensure it has the correct permissions
ENV TMPDIR=/home/container/tmp
RUN mkdir -p $TMPDIR && chmod 777 $TMPDIR

# Copy go.mod and go.sum
COPY go.mod go.sum ./
COPY ./example ./example
RUN go mod download && go mod verify
# Install Go 1.22.1
#RUN wget https://golang.org/dl/go1.22.1.linux-amd64.tar.gz && \
#    tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz && \
#    rm go1.22.1.linux-amd64.tar.gz
#RUN wget https://github.com/cooldogedev/spectrum.git

# Set up Go environment
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"
ENV GO111MODULE="on"

# Verify Go installation
RUN go version



#RUN wget https://github.com/cooldogedev/spectrum/archive/refs/heads/main.zip
# Set up the working directory
#WORKDIR /app

# Copy your application code to the container
#COPY . /app

# Download and install Go modules
#RUN go mod tidy
# Build your application
#RUN go build -o spectrum-server

# Expose the port your application will run on
#EXPOSE 8080

# Command to run your application
#CMD ["./spectrum-server"]
ENV GOCACHE=/tmp/go-build-cache
CMD ["go", "run", "/home/container/example/api.go"]
