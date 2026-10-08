const http = require('http');
const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

const PORT = 8088;
const WEB_DIR = path.join(__dirname, 'build', 'web');

const MIME_TYPES = {
  '.html': 'text/html; charset=UTF-8',
  '.js': 'application/javascript; charset=UTF-8',
  '.mjs': 'application/javascript; charset=UTF-8',
  '.css': 'text/css; charset=UTF-8',
  '.json': 'application/json',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.wasm': 'application/wasm',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2',
  '.ttf': 'font/ttf',
  '.ico': 'image/x-icon',
  '.mp3': 'audio/mpeg',
  '.ogg': 'audio/ogg'
};

const server = http.createServer((req, res) => {
  let reqPath = decodeURI(req.url.split('?')[0]);
  if (reqPath === '/' || reqPath === '') {
    reqPath = '/index.html';
  }

  const filePath = path.join(WEB_DIR, reqPath);

  // Prevent directory traversal
  if (!filePath.startsWith(WEB_DIR)) {
    res.writeHead(403);
    res.end('Access denied');
    return;
  }

  fs.stat(filePath, (err, stats) => {
    if (err || !stats.isFile()) {
      // Fallback to index.html for SPA routing if needed
      const indexPath = path.join(WEB_DIR, 'index.html');
      fs.readFile(indexPath, (err2, content) => {
        if (err2) {
          res.writeHead(404, { 'Content-Type': 'text/plain; charset=UTF-8' });
          res.end('Dosya bulunamadi. Lutfen once "flutter build web" yapiniz.');
        } else {
          res.writeHead(200, { 'Content-Type': 'text/html; charset=UTF-8' });
          res.end(content);
        }
      });
      return;
    }

    const ext = path.extname(filePath).toLowerCase();
    const contentType = MIME_TYPES[ext] || 'application/octet-stream';

    res.writeHead(200, {
      'Content-Type': contentType,
      'Cache-Control': 'no-cache',
      'Cross-Origin-Opener-Policy': 'same-origin',
      'Cross-Origin-Embedder-Policy': 'require-corp'
    });

    const stream = fs.createReadStream(filePath);
    stream.pipe(res);
  });
});

server.listen(PORT, 'localhost', () => {
  console.log(`\n===============================================================`);
  console.log(`  CHEFMERGE OYUNU CALISIYOR: http://localhost:${PORT}`);
  console.log(`  Tarayiciniz otomatik acildi. Oyunu kapatmak icin Ctrl+C yapin.`);
  console.log(`===============================================================\n`);

  // Open browser
  const startCmd = process.platform === 'win32' ? `start http://localhost:${PORT}` : `xdg-open http://localhost:${PORT}`;
  exec(startCmd);
});
