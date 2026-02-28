FROM node:24-alpine

WORKDIR /app

# Install deps
COPY package*.json ./
RUN npm install

# Copy source
COPY . .

# Create dirs
RUN mkdir -p /app/data /app/packages/server/dist

EXPOSE $PORT

# Find and run the ACTUAL server file
CMD ["sh", "-c", "find packages/server -name '*.js' -path '*/server*' | head -1 | xargs node || node packages/server/index.js || npm start || echo 'No server found'"]
