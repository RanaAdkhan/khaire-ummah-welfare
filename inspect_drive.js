const fs = require('fs');

const content = fs.readFileSync('drive_page.html', 'utf8');

// Look for data payload
const dsMatches = content.match(/_data_ = (\[.*?\]);<\/script>/s) || content.match(/window\['_DRIVE_ivd'\] = '([^']+)';/);
if (dsMatches) {
    console.log("Found _DRIVE_ivd or data payload");
}

// Search for any .jpg or .png or image names
const imgNames = content.match(/[^"'\\]+\.(jpg|jpeg|png|webp|JPG|PNG)/gi);
console.log("Image filenames found in page:", imgNames ? imgNames.slice(0, 30) : "none");

// Search for file items
const chunkRegex = /\["([a-zA-Z0-9_-]{33})",\["([^"]+)"/g;
let m;
const items = [];
while ((m = chunkRegex.exec(content)) !== null) {
    items.push({ id: m[1], name: m[2] });
}
console.log("Items with 33-char ID:", items.length, items.slice(0, 10));
