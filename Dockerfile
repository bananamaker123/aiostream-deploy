FROM node:24-alpine

WORKDIR /app

# Install dependencies including ts-node for running TypeScript directly
COPY package*.json ./
RUN npm install && npm install -g ts-node typescript

# Copy all source files
COPY . .

# Ensure data directory exists
RUN mkdir -p /app/data

EXPOSE $PORT

# Run the TypeScript server file directly
CMD ["ts-node", "packages/server/src/server.ts"]
