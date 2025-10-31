FROM ubuntu:22.04

LABEL maintainer="jmanani@student.42heilbronn.de"
LABEL version="1.0.0"
LABEL description="francinette docker image 42 - Local Testing Setup"

# Install dependencies
RUN apt update -y && apt upgrade -y
RUN apt install -y git gcc clang libpq-dev libbsd-dev libncurses-dev \
                   valgrind build-essential nasm cmake make libxext-dev \
                   python3-dev python3-pip python3-venv python3-wheel

# Create a virtual environment
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Set the working directory inside the container
WORKDIR /francinette

# Copy the current local directory into the container
COPY . /francinette

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install wheel
RUN pip install -r requirements.txt
RUN pip install norminette

# Make tester.sh executable
RUN chmod +x tester.sh

# Default command
CMD ["/francinette/tester.sh"]

