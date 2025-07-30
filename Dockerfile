FROM debian:bullseye

# Install dependencies
RUN apt-get update && apt-get install -y  \
    build-essential \
    git \
    qemu-system-x86 \
    python3 \
    curl \
    make \
    gcc \
    gdb \
    nasm \
    libgcc-9-dev \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory to /xv6
WORKDIR /xv6

# Clone the xv6-public repository
RUN git clone https://github.com/mit-pdos/xv6-public.git

# Change working directory to the cloned repo
WORKDIR /xv6/xv6-public

# Default command to run when the container starts
CMD ["/bin/bash"]

