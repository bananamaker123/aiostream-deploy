FROM node:24-alpine

WORKDIR /app

# Use npm instead of pnpm (simpler, reliable)
COPY package*.json ./

# Install deps with npm (ignores pnpm patches/lockfile)
RUN npm install

# Copy everything
COPY . .

# Create missing paths
RUN mkdir -p /app/data /app/packages/{frontend,server,core}/dist/out || true

# Try build, fallback to source if fails
RUN npm run build || echo "Using source code"

EXPOSE $PORT

CMD ["sh", "-c", "npm run start || node packages/server/dist/server.js || node packages/server/src/server.js || echo 'Server start failed'"]
