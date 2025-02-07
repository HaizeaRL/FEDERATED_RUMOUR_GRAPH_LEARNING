# Use a lightweight Python image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /usr/local/app

# Install system dependencies required for Matplotlib and X11 forwarding
RUN apt-get update && apt-get install -y \
    libx11-dev \
    libatlas-base-dev \
    libglib2.0-0 \
    x11-apps \
    && rm -rf /var/lib/apt/lists/*
    
# Install packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code to the container
COPY . .

# Accept build arguments 
ARG ROLE

# Create the directory and save the role file in it
RUN mkdir -p /usr/local/app/tmp/ && \
    echo "$ROLE" > /usr/local/app/tmp/role.txt

# Default command for the container
CMD ["python", "-u", "./src/dispatcher.py"]
