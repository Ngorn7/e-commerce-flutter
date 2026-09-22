const https = require('https');

function searchUnsplash(query) {
    https.get(`https://unsplash.com/napi/search/photos?query=${encodeURIComponent(query)}&per_page=1`, (res) => {
        let data = '';
        res.on('data', chunk => data += chunk);
        res.on('end', () => {
            try {
                const parsed = JSON.parse(data);
                console.log(`${query}: ${parsed.results[0].urls.regular}`);
            } catch (e) {
                console.error(e);
            }
        });
    }).on('error', err => console.error(err));
}

searchUnsplash('granola bar');
searchUnsplash('ground beef');
