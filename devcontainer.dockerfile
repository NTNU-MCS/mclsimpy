FROM ubuntu:22.04

# Copy python package dependencies
COPY requirements.txt /tmp/requirements.txt

# Install python, system tools, and some python dependencies
RUN apt update && apt upgrade -yq ;\
    apt install -yq \
        python3 \
        python3-pip \
        python3-venv \
        curl \
        git \
        sudo ;\
    pip install -r /tmp/requirements.txt ;\
    curl -sSL https://get.docker.com/ | sh ;\
    apt autoclean

# Create a user named 'developer' and assign sudo rules to it
RUN adduser --disabled-password --gecos '' developer ;\
    adduser developer sudo ;\
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set environment variables to seamlessly work with python
ENV PATH="${PATH}:/home/developer/.local/bin"
ENV PYTHONPATH="${PYTHONPATH}:/com.docker.devenvironments.code/src"

# Use the user 'developer' for the dev container
USER developer