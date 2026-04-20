FROM node:20-slim

RUN apt-get update && apt-get install -y \
    chromium \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN npm install prerender
COPY server.js .

EXPOSE 10000

CMD ["node", "server.js"]
