const fs = require('fs');
const https = require('https');
const path = require('path');

const content = fs.readFileSync('drive_page.html', 'utf8');

// Parse drive JSON structures
// In Google Drive folder HTML, files are serialized in JS arrays: [ "id", "name", "mimeType", ... ]
const fileMatches = [];
const regex = /\["([a-zA-Z0-9_-]{33})","([^"]+\.(?:jpg|jpeg|png|webp|JPG|JPEG|PNG))","image\/[^"]+"/g;
let match;
while ((match = regex.exec(content)) !== null) {
    fileMatches.push({ id: match[1], name: match[2] });
}

console.log('Found direct image files:', fileMatches.length);

// Also look for broader image patterns
if (fileMatches.length === 0) {
    const broadRegex = /\["([a-zA-Z0-9_-]{28,35})","([^"]+)"/g;
    let bMatch;
    while ((bMatch = broadRegex.exec(content)) !== null) {
        if (bMatch[2].match(/\.(jpg|jpeg|png|webp|mp4)/i) || bMatch[2].length > 3) {
            fileMatches.push({ id: bMatch[1], name: bMatch[2] });
        }
    }
}

console.log('Total identified items:', fileMatches.length);
console.log(fileMatches.slice(0, 15));

// Create gallery directory
const outDir = path.join(__dirname, 'images', 'gallery');
if (!fs.existsSync(outDir)) fs.mkdirSync(outDir, { recursive: true });

fs.writeFileSync('drive_files.json', JSON.stringify(fileMatches, null, 2));
