import urllib.request
import re
import json
import os

url = 'https://drive.google.com/drive/folders/1s9MnwqdiWxLfv2rsvgVVBronkVRmk5Zr?usp=sharing'
req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'})
try:
    html = urllib.request.urlopen(req, timeout=15).read().decode('utf-8')
    with open('drive_page.html', 'w', encoding='utf-8') as f:
        f.write(html)
    print('Saved drive_page.html, size:', len(html))
except Exception as e:
    print('Fetch error:', e)
