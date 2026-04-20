FROM zenika/alpine-chrome:with-node

WORKDIR /app
COPY package.json .
RUN npm install
COPY server.js .

# Verificar dónde está Chrome en esta imagen
RUN which chromium-browser || which chromium || find / -name "chromium*" -type f 2>/dev/null | head -5

EXPOSE 10000

CMD ["node", "server.js"]


