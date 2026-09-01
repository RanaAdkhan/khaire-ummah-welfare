const fs = require('fs');
const https = require('https');
const path = require('path');

const content = fs.readFileSync('drive_page.html', 'utf8');

// Find all matches for filename and ID nearby
// In Google Drive HTML: ["IMG-20260329-WA0115.jpg", ... "1nWWMxuHdeg0HEnlN3l6FBYfjnTMtu2ht" ...]
// Let's regex search around each image filename
const imgRegex = /(IMG-\d+-WA\d+\.jpg)/g;
let m;
const files = [];

// Split by filename
const parts = content.split(/(IMG-\d+-WA\d+\.jpg)/);

for (let i = 1; i < parts.length; i += 2) {
    const filename = parts[i];
    const surrounding = parts[i - 1].slice(-300) + filename + parts[i + 1].slice(0, 300);
    // Find ID (usually 33 alphanumeric chars starting with 1 or similar)
    const idMatch = surrounding.match(/"(1[a-zA-Z0-9_-]{32})"/);
    if (idMatch) {
        if (!files.some(f => f.id === idMatch[1])) {
            files.push({ name: filename, id: idMatch[1] });
        }
    }
}

console.log("Found files count:", files.length);
console.log(files);

fs.writeFileSync('drive_gallery_files.json', JSON.stringify(files, null, 2));
