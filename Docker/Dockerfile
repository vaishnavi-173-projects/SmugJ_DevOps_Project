# Use a secure, lightweight official Python minimal footprint image
FROM python:3.9-slim

# Set the operational directory inside the container
WORKDIR /app

# Copy dependency mappings first to leverage Docker layer caching
COPY requirements.txt .

# Install dependencies without saving cache to keep image size small
RUN pip install --no-cache-dir -r requirements.txt

# Copy application runtime source code
COPY app.py .

# Expose the internal routing port
EXPOSE 5000

# Run the application securely
CMD ["python", "app.py"]