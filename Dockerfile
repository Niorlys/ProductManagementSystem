FROM python:3.12-alpine

# Install dependencies since we may use
# libraries that need them at runtime like numpy, scipy, etc.
RUN apk add --no-cache gcc musl-dev

COPY df_entrypoint.sh /app/df_entrypoint.sh

RUN chmod +x /app/df_entrypoint.sh

ENTRYPOINT ["/bin/sh", "/app/df_entrypoint.sh"]

# Copy requirements.txt and install Python dependencies
# This step is cached if requirements.txt doesn't change
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt


COPY . /app

WORKDIR /app

# Running the server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
