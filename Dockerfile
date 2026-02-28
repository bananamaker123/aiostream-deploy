FROM node:24-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE $PORT

# SHOW US EVERYTHING, then sleep so we can read logs
CMD ["sh", "-c", "
  echo '=== ROOT CONTENTS ===' && ls -la && echo '',
  echo '=== PACKAGES/SERVER CONTENTS ===' && ls -la packages/server/ || echo 'NO packages/server', 
  echo '=== packages/server/src CONTENTS ===' && find packages/server -name '*.ts' | head -10 || echo 'NO TS files',
  echo '=== package.json scripts ===' && grep -A10 'scripts' package.json || echo 'NO scripts',
  echo '=== SLEEPING 300s ===' && sleep 300
"]
