
FROM python:3.13.5-alpine3.22

# Set the working directory inside the container
WORKDIR /app

# Copy the file with the dependencies first to leverage Docker's layer caching.
# If requirements.txt doesn't change, this layer won't be rebuilt on subsequent builds.
COPY requirements.txt .

# Install the dependencies
# --no-cache-dir reduces image size by not storing the pip cache.
# --upgrade pip ensures the latest pip version is used.
RUN pip install --no-cache-dir --upgrade pip -r requirements.txt

# Copy the rest of the application source code into the working directory
COPY . .

# Expose the port that the application will run on
EXPOSE 8000

# Command to run the application using uvicorn
# --host 0.0.0.0 makes the server accessible from outside the container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]