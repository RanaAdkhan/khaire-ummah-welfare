const https = require('https');
const fs = require('fs');

const url = 'https://drive.google.com/drive/folders/1s9MnwqdiWxLfv2rsvgVVBronkVRmk5Zr?usp=sharing';

https.get(url, {
    headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
    }
}, (res) => {
    let data = '';
    res.on('data', (chunk) => data += chunk);
    res.on('end', () => {
        fs.writeFileSync('drive_page.html', data);
        console.log('Downloaded drive page. Length:', data.length);
        
        // Find file IDs and names in data
        const idRegex = /"([-\w]{28,35})"/g;
        const matches = new Set();
        let m;
        while ((m = idRegex.exec(data)) !== null) {
            if (m[1] !== '1s9MnwqdiWxLfv2rsvgVVBronkVRmk5Zr') {
                matches.add(m[1]);
            }
        }
        console.log('Extracted IDs count:', matches.size);
        console.log('Sample IDs:', Array.from(matches).slice(0, 20));
    });
}).on('error', (err) => {
    console.error('Error:', err);
});
