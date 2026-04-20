const prerender = require('prerender');

const server = prerender({
  chromeLocation: '/usr/bin/chromium-browser',
  chromeFlags: [
    '--no-sandbox',
    '--disable-setuid-sandbox',
    '--disable-dev-shm-usage',
    '--disable-gpu',
    '--headless',
    '--single-process',
    '--no-zygote',
  ],
});

server.start();
