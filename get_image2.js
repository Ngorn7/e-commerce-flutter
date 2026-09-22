const https = require('https');

function search(query) {
    https.get(`https://unsplash.com/s/photos/${query}`, (res) => {
        let data = '';
        res.on('data', chunk => data += chunk);
        res.on('end', () => {
            const match = data.match(/https:\/\/images\.unsplash\.com\/photo-[a-zA-Z0-9-]+/);
            if (match) {
                console.log(`${query}: ${match[0]}`);
            } else {
                console.log(`${query}: not found`);
            }
        });
    });
}

search('granola-bar');
search('ground-beef');
