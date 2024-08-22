# Use a base image that is appropriate for your needs
FROM debian:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    wget \
    tar \
    build-essential

# Install Go 1.22.1
RUN wget https://golang.org/dl/go1.22.1.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz && \
    rm go1.22.1.linux-amd64.tar.gz
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /usr/share/keyrings/githubcli-archive-keyring.gpg
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list
RUN apt-get update && apt-get install -y gh    

# Set up Go environment
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"
ENV GO111MODULE="on"

# Verify Go installation
RUN go version

# Set up the working directory
WORKDIR /app

# Copy your application code to the container
COPY . /app

# Download and install Go modules
#RUN go mod tidy
RUN gh repo clone cooldogedev/spectrum
# Build your application
RUN go build -o spectrum-server

# Expose the port your application will run on
#EXPOSE 8080

# Command to run your application
CMD ["./spectrum-server"]
