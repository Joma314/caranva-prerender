FROM node:20-slim

RUN apt-get update && apt-get install -y \
    chromium \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN npm install prerender

RUN echo "const prerender = require('prerender');\
const server = prerender({\
  chromeLocation: '/usr/bin/chromium',\
  chromeFlags: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage', '--disable-gpu', '--headless']\
});\
server.start();" > server.js

EXPOSE 10000

CMD ["node", "server.js"]
