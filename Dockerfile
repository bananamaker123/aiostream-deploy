FROM node:24-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . .
RUN mkdir -p /app/data /app/packages/server/dist

EXPOSE $PORT

# MOST COMMON AIOSTREAMS ENTRYPOINT
CMD ["sh", "-c", "cd packages/server && npm start || node src/server.js || node index.js || npm run dev"]
