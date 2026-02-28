# Ultra-simple Render-ready AIOStreams
FROM node:24-alpine

WORKDIR /app

# Copy ONLY essential package files first
COPY package*.json pnpm-lock.yaml pnpm-workspace.yaml ./

# Install pnpm + deps (ignore missing patches)
RUN corepack enable && \
    pnpm install --frozen-lockfile --network-timeout 600000 || true && \
    pnpm install

# Copy everything else
COPY . .

# Build (skip if fails)
RUN pnpm run build || echo "Build skipped"

# Production deps only
RUN pnpm prune --prod || npm install

# Create missing folders
RUN mkdir -p /app/data /app/packages/frontend/out /app/packages/server/dist

EXPOSE $PORT

CMD ["sh", "-c", "cd packages/server && node dist/server.js || node src/server.js"]
