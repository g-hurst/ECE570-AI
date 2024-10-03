# Use an official Python runtime as a parent image
FROM python:3.10

# Set the working directory to /ece57000
WORKDIR /ece57000

# Install Jupyter Notebook
RUN pip install jupyter

# Install any needed packages specified in requirements.txt
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# installs spesific for FinRL
RUN pip install wrds swig
RUN apt-get update -y -qq
RUN apt-get install -y -qq \
                cmake \
                libopenmpi-dev \
                python3-dev \
                zlib1g-dev \
                libgl1-mesa-glx \
                swig

# install my fork with a few changes
RUN pip install git+https://github.com/g-hurst/FinRL

# Make port 8888 available to the world outside this container
EXPOSE 8888

# Run Jupyter Notebook when the container launches
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]