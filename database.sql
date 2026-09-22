CREATE DATABASE IF NOT EXISTS ecommerce_db;

USE ecommerce_db;

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    image VARCHAR(500),
    category VARCHAR(100) NOT NULL,
    is_exclusive BOOLEAN DEFAULT FALSE,
    is_best_selling BOOLEAN DEFAULT FALSE,
    is_grocery BOOLEAN DEFAULT FALSE,
    stock INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO
    products (
        name,
        description,
        price,
        image,
        category,
        is_exclusive,
        is_best_selling,
        is_grocery,
        stock
    )
VALUES (
        'Fresh Red Apple',
        'Crisp and juicy red apples, hand-picked and perfect for snacking.',
        2.50,
        'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6',
        'Fruits',
        TRUE,
        TRUE,
        TRUE,
        120
    ),
    (
        'Ripe Banana Bunch',
        'Sweet, energy-packed bananas sold in bunches of six.',
        1.80,
        'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e',
        'Fruits',
        FALSE,
        TRUE,
        TRUE,
        200
    ),
    (
        'Seedless Watermelon',
        'Refreshing seedless watermelon, great for hot summer days.',
        4.99,
        'https://images.unsplash.com/photo-1587049352846-4a222e784d38',
        'Fruits',
        TRUE,
        FALSE,
        TRUE,
        60
    ),
    (
        'Organic Strawberries',
        'Sweet organic strawberries, pesticide-free and locally grown.',
        3.75,
        'https://images.unsplash.com/photo-1518635017498-87f514b751ba',
        'Fruits',
        TRUE,
        TRUE,
        TRUE,
        80
    ),
    (
        'Fresh Carrots',
        'Crunchy orange carrots, rich in beta-carotene and fiber.',
        1.20,
        'https://images.unsplash.com/photo-1447175008436-054170c2e979',
        'Vegetables',
        FALSE,
        TRUE,
        TRUE,
        150
    ),
    (
        'Broccoli Florets',
        'Fresh green broccoli florets, ready to steam or stir-fry.',
        2.10,
        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
        'Vegetables',
        FALSE,
        FALSE,
        TRUE,
        90
    ),
    (
        'Organic Spinach',
        'Tender organic spinach leaves, washed and ready to cook.',
        2.30,
        'https://images.unsplash.com/photo-1576045057995-568f588f82fb',
        'Vegetables',
        TRUE,
        FALSE,
        TRUE,
        70
    ),
    (
        'Red Bell Pepper',
        'Sweet and crunchy red bell peppers, great for salads.',
        1.60,
        'https://images.unsplash.com/photo-1563565375-f3fdfdbefa83',
        'Vegetables',
        FALSE,
        FALSE,
        TRUE,
        100
    ),
    (
        'Whole Milk 1L',
        'Fresh pasteurized whole milk, rich and creamy.',
        1.99,
        'https://images.unsplash.com/photo-1550583724-b2692b85b150',
        'Dairy',
        FALSE,
        TRUE,
        TRUE,
        200
    ),
    (
        'Greek Yogurt',
        'Thick and creamy Greek yogurt, high in protein.',
        2.80,
        'https://images.unsplash.com/photo-1571212515416-fef01fc43637',
        'Dairy',
        TRUE,
        TRUE,
        TRUE,
        110
    ),
    (
        'Cheddar Cheese Block',
        'Aged cheddar cheese with a sharp, rich flavor.',
        5.50,
        'https://images.unsplash.com/photo-1618164436241-4473940d1f5c',
        'Dairy',
        TRUE,
        FALSE,
        TRUE,
        40
    ),
    (
        'Farm Fresh Eggs (12pk)',
        'Free-range chicken eggs, a dozen per carton.',
        3.20,
        'https://images.unsplash.com/photo-1518569656558-1f25e69d93d7',
        'Dairy',
        FALSE,
        TRUE,
        TRUE,
        130
    ),
    (
        'Sourdough Bread Loaf',
        'Freshly baked sourdough bread with a crispy crust.',
        3.40,
        'https://images.unsplash.com/photo-1509440159596-0249088772ff',
        'Bakery',
        TRUE,
        TRUE,
        TRUE,
        55
    ),
    (
        'Chocolate Croissant',
        'Buttery croissant filled with rich dark chocolate.',
        2.20,
        'https://images.unsplash.com/photo-1555507036-ab1f4038808a',
        'Bakery',
        FALSE,
        TRUE,
        TRUE,
        75
    ),
    (
        'Blueberry Muffin',
        'Soft muffin loaded with fresh blueberries.',
        1.90,
        'https://images.unsplash.com/photo-1607958996333-41aef7caefaa',
        'Bakery',
        FALSE,
        FALSE,
        TRUE,
        85
    ),
    (
        'Orange Juice 1L',
        'Freshly squeezed orange juice, no added sugar.',
        2.60,
        'https://images.unsplash.com/photo-1600271886742-f049cd451bba',
        'Drinks',
        TRUE,
        TRUE,
        TRUE,
        95
    ),
    (
        'Sparkling Water 500ml',
        'Refreshing carbonated water, zero calories.',
        1.10,
        'https://images.unsplash.com/photo-1523362628745-0c100150b504',
        'Drinks',
        FALSE,
        FALSE,
        TRUE,
        180
    ),
    (
        'Cold Brew Coffee',
        'Smooth cold brew coffee, brewed for 18 hours.',
        3.10,
        'https://images.unsplash.com/photo-1461023058943-07fcbe16d735',
        'Drinks',
        TRUE,
        TRUE,
        TRUE,
        65
    ),
    (
        'Potato Chips',
        'Crispy salted potato chips, family size bag.',
        2.00,
        'https://images.unsplash.com/photo-1566478989037-eec170784d0b',
        'Snacks',
        FALSE,
        TRUE,
        TRUE,
        140
    ),
    (
        'Mixed Nuts Pack',
        'A healthy mix of almonds, cashews, and walnuts.',
        4.20,
        'https://images.unsplash.com/photo-1508061253366-f7da158b6d46',
        'Snacks',
        TRUE,
        FALSE,
        TRUE,
        60
    ),
    (
        'Granola Bars (6pk)',
        'Crunchy oat granola bars with honey and nuts.',
        3.00,
        'https://images.unsplash.com/photo-1508061253366-f7da158b6d46',
        'Snacks',
        FALSE,
        TRUE,
        TRUE,
        100
    ),
    (
        'Chicken Breast 1kg',
        'Fresh boneless chicken breast, trimmed and ready to cook.',
        6.50,
        'https://images.unsplash.com/photo-1604503468506-a8da13d82791',
        'Meat',
        TRUE,
        TRUE,
        TRUE,
        45
    ),
    (
        'Ground Beef 500g',
        'Premium lean ground beef, great for burgers and pasta.',
        5.80,
        'https://images.unsplash.com/photo-1555939594-58d7cb561ad1',
        'Meat',
        FALSE,
        TRUE,
        TRUE,
        50
    ),
    (
        'Salmon Fillet 500g',
        'Fresh Atlantic salmon fillet, rich in omega-3.',
        8.90,
        'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2',
        'Meat',
        TRUE,
        FALSE,
        TRUE,
        30
    );