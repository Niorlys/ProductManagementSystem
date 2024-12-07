# For running the django server
FROM python:3.12-alpine

# Install dependencies since we may use
# libraries that need them at runtime like
# numpy, scipy, etc.
RUN apk add --no-cache gcc musl-dev

# Install python dependencies layer
# Since dependecies change less frequently than the application code,
# we can cache the dependencies layer to speed up the build process
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the application code
COPY . .

# Run the django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

