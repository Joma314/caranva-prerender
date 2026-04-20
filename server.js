const express = require('express');
const puppeteer = require('puppeteer-core');

const app = express();
const PORT = process.env.PORT || 10000;

let browser;

async function getBrowser() {
  if (!browser || !browser.isConnected()) {
    browser = await puppeteer.launch({
      executablePath: '/usr/bin/chromium-browser',
      args: [
        '--no-sandbox',
        '--disable-setuid-sandbox',
        '--disable-dev-shm-usage',
        '--disable-gpu',
        '--headless',
        '--single-process',
        '--no-zygote',
      ],
    });
  }
  return browser;
}

app.get('/*', async (req, res) => {
  const url = req.url.slice(1);
  if (!url.startsWith('http')) {
    return res.status(400).send('Invalid URL');
  }
  console.log('Rendering:', url);
  try {
    const b = await getBrowser();
    const page = await b.newPage();
    await page.goto(url, { waitUntil: 'networkidle0', timeout: 30000 });
    const html = await page.content();
    await page.close();
    res.set('Content-Type', 'text/html; charset=utf-8');
    res.send(html);
  } catch (err) {
    console.error('Error:', err.message);
    res.status(500).send('Error rendering page');
  }
});

app.listen(PORT, () => {
  console.log('Prerender server running on port', PORT);
});
