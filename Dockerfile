# Use the official Ubuntu base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the default version as python 3
RUN ln -s /usr/bin/python3 /usr/bin/python

#Install pip for python 3
RUN python -m pip install --upgrade pip --break-system-packages

# Set workdir inside container
WORKDIR /

# Create directory for app code
RUN mkdir Code
ADD ./Code /Code

WORKDIR Code

# Install Python dependencies
RUN pip install -r ./requirements.txt --break-system-packages

# Expose the port that the FastAPI app will run on
# EXPOSE 8001

# Command to run the FastAPI app
# CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
CMD uvicorn settings:app --host 0.0.0.0 --port 8001 --workers 1