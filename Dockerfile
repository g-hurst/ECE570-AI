FROM nvidia/cuda:12.6.0-cudnn8-devel-ubuntu20.04

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

# installs spesific for FinRL
RUN apt-get update -y 
RUN apt-get install -y  \
                libopenmpi-dev \
                python3-dev \
                libgl1-mesa-glx \
                swig

# install python3.9 
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y python3.9 python3-pip

# Install Jupyter Notebook
RUN pip install jupyter

# Install any needed packages specified in requirements.txt
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt 

# install my fork with a few changes
# RUN pip install git+https://github.com/g-hurst/FinRL

# Make port 8888 available to the world outside this container
EXPOSE 8888

# Run Jupyter Notebook when the container launches
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]