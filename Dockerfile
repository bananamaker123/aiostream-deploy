FROM node:24-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE $PORT

CMD ["sh", "-c", "echo '=== ROOT CONTENTS ===' && ls -la && echo '' && echo '=== PACKAGES/SERVER ===' && ls -la packages/server/ || echo 'NO packages/server' && echo '=== TS FILES ===' && find packages/server -name '*.ts' | head -10 || echo 'NO TS files' && echo '=== package.json scripts ===' && grep -A10 'scripts' package.json || echo 'NO scripts' && echo 'SLEEPING...' && sleep 300"]
