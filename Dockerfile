# Simple single-stage Node.js build for Render
FROM node:20-alpine

WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./
COPY pnpm-lock.yaml ./
COPY pnpm-workspace.yaml ./

# Install pnpm and dependencies
RUN corepack enable && pnpm install --frozen-lockfile

# Copy ALL source files
COPY . .

# Build the project
RUN pnpm run build

# Remove dev dependencies, install production only
RUN pnpm prune --prod

# Expose port for Render
EXPOSE $PORT

# Healthcheck (optional)
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD node /app/scripts/healthcheck.js || exit 1

# Start server
CMD ["node", "packages/server/dist/server.js"]
