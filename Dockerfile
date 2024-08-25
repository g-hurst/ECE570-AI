# Use an official Python runtime as a parent image
FROM python:3.9

# Set the working directory to /ece57000
WORKDIR /ece57000

# Install Jupyter Notebook
RUN pip install jupyter

# Install any needed packages specified in requirements.txt
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8888 available to the world outside this container
EXPOSE 8888

# Run Jupyter Notebook when the container launches
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]