FROM zenika/alpine-chrome:with-node

WORKDIR /app
COPY package.json .
RUN npm install
COPY server.js .

EXPOSE 10000

CMD ["node", "server.js"]
