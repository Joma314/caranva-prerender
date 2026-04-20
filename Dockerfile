FROM zenika/alpine-chrome:with-node

WORKDIR /app
RUN npm install prerender
COPY server.js .

EXPOSE 10000

CMD ["node", "server.js"]
