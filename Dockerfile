FROM ghcr.io/puppeteer/puppeteer:22

USER root
WORKDIR /app

RUN npm install prerender

EXPOSE 10000

CMD node -e "const prerender = require('prerender'); const server = prerender(); server.start();"
