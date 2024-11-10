# FROM nvidia/cuda:12.6.1-cudnn-runtime-ubuntu20.04
from python:3.9

# Set the working directory to /ece57000
WORKDIR /ece57000

# install common dependancies 
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
                clang \
                build-essential \
                bash \
                ca-certificates \
                git \
                wget \
                cmake \
                curl \
                software-properties-common \
                ffmpeg \
                libsm6 \
                libxext6 \
                libffi-dev \
                libssl-dev \
                xz-utils \
                zlib1g-dev \
                liblzma-dev \ 
                libglib2.0-0

# Install Jupyter Notebook
RUN pip install jupyter

# Install any needed packages specified in requirements.txt
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt 

# Make port 8888 available to the world outside this container
EXPOSE 8888

# Run Jupyter Notebook when the container launches
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
