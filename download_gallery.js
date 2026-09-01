const fs = require('fs');
const https = require('https');
const path = require('path');

const files = JSON.parse(fs.readFileSync('drive_gallery_files.json', 'utf8'));
const outDir = path.join(__dirname, 'images', 'gallery');
if (!fs.existsSync(outDir)) fs.mkdirSync(outDir, { recursive: true });

async function downloadFile(item) {
    return new Promise((resolve) => {
        const destPath = path.join(outDir, item.name);
        if (fs.existsSync(destPath) && fs.statSync(destPath).size > 1000) {
            return resolve(true);
        }
        
        // Google usercontent direct thumbnail URL (high-res w800)
        const url = `https://lh3.googleusercontent.com/u/0/d/${item.id}=w800`;
        
        const req = https.get(url, { headers: { 'User-Agent': 'Mozilla/5.0' } }, (res) => {
            if (res.statusCode >= 300 && res.statusCode < 400 && res.headers.location) {
                https.get(res.headers.location, (redirectRes) => {
                    const fileStream = fs.createWriteStream(destPath);
                    redirectRes.pipe(fileStream);
                    fileStream.on('finish', () => { fileStream.close(); resolve(true); });
                }).on('error', () => resolve(false));
            } else if (res.statusCode === 200) {
                const fileStream = fs.createWriteStream(destPath);
                res.pipe(fileStream);
                fileStream.on('finish', () => { fileStream.close(); resolve(true); });
            } else {
                resolve(false);
            }
        });
        req.on('error', () => resolve(false));
    });
}

async function main() {
    console.log(`Starting download of ${files.length} gallery images...`);
    let downloaded = 0;
    for (const item of files) {
        const ok = await downloadFile(item);
        if (ok) {
            downloaded++;
            process.stdout.write(`.` );
        }
    }
    console.log(`\nFinished. Successfully saved ${downloaded} gallery photos in images/gallery!`);
}

main();
