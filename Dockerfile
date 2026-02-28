# Use lightweight Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy files
COPY . .

# Install dependencies
RUN pip install -r requirements.txt

# Expose dynamic port
ENV PORT=8080
EXPOSE 8080

# Run app
CMD ["python", "app.py"]
