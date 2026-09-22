const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'Kim ngon2',
  database: 'ecommerce_db'
});

const fixGranola = `UPDATE products SET image = 'https://images.unsplash.com/photo-1508061253366-f7da158b6d46' WHERE name = 'Granola Bars (6pk)'`;
const fixBeef = `UPDATE products SET image = 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1' WHERE name = 'Ground Beef 500g'`;

connection.query(fixGranola, (err, results) => {
  if (err) console.error(err);
  else console.log('Fixed granola bars image in DB');
  
  connection.query(fixBeef, (err, results) => {
    if (err) console.error(err);
    else console.log('Fixed ground beef image in DB');
    
    connection.end();
  });
});
