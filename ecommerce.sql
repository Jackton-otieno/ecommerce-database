create database e_commerce
use e_commerce



-- 1. Brand Table
CREATE TABLE brand (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- 2. Product Category
CREATE TABLE product_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- 3. Product
CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    base_price DECIMAL(10,2) NOT NULL,
    brand_id INT,
    category_id INT,
    FOREIGN KEY (brand_id) REFERENCES brand(id),
    FOREIGN KEY (category_id) REFERENCES product_category(id)
);

-- 4. Product Image
CREATE TABLE product_image (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    image_url VARCHAR(500),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

-- 5. Color
CREATE TABLE color (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hex_code VARCHAR(7)  -- e.g., #FFFFFF
);

-- 6. Size Category
CREATE TABLE size_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- 7. Size Option
CREATE TABLE size_option (
    id INT AUTO_INCREMENT PRIMARY KEY,
    label VARCHAR(50) NOT NULL,
    size_category_id INT,
    FOREIGN KEY (size_category_id) REFERENCES size_category(id)
);

-- 8. Product Variation
CREATE TABLE product_variation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    color_id INT,
    size_option_id INT,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (color_id) REFERENCES color(id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(id)
);

-- 9. Product Item
CREATE TABLE product_item (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_variation_id INT,
    sku VARCHAR(255) UNIQUE NOT NULL,
    stock_quantity INT DEFAULT 0,
    price DECIMAL(10,2),
    FOREIGN KEY (product_variation_id) REFERENCES product_variation(id)
);

-- 10. Attribute Category
CREATE TABLE attribute_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- 11. Attribute Type
CREATE TABLE attribute_type (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    data_type ENUM('text', 'number', 'boolean') NOT NULL
);

-- 12. Product Attribute
-- 12. Product Attribute
CREATE TABLE product_attribute (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    attribute_category_id INT,
    attribute_type_id INT,
    name VARCHAR(255) NOT NULL,
    value VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(id)
);



-- Insert Brands
INSERT INTO brand (name, description) VALUES
('Nike', 'Leading sportswear brand'),
('Apple', 'Technology and electronics company'),
('Adidas', 'Performance sportswear and shoes'),
('Samsung', 'Electronics and smart devices'),
('Sony', 'Entertainment and technology brand');

-- Insert Product Categories
INSERT INTO product_category (name, description) VALUES
('Clothing', 'Apparel and garments'),
('Electronics', 'Gadgets and devices'),
('Footwear', 'Shoes, sandals, boots'),
('Accessories', 'Watches, bags, jewelry');

-- Insert Products
INSERT INTO product (name, description, base_price, brand_id, category_id) VALUES
('iPhone 14', 'Latest Apple smartphone with advanced features', 999.99, 2, 2),
('Running Shoes', 'Comfortable and durable sports shoes', 120.00, 1, 3),
('Galaxy S23', 'Flagship Samsung smartphone', 899.99, 4, 2),
('UltraBoost 22', 'Premium Adidas running shoes', 180.00, 3, 3),
('Sony WH-1000XM5', 'Noise-canceling wireless headphones', 349.99, 5, 2),
('Nike Dri-FIT Shirt', 'Breathable sports T-shirt', 45.00, 1, 1);

-- Insert Product Images
INSERT INTO product_image (product_id, image_url) VALUES
(1, 'https://example.com/images/iphone14.jpg'),
(2, 'https://example.com/images/runningshoes.jpg'),
(3, 'https://example.com/images/galaxys23.jpg'),
(4, 'https://example.com/images/ultraboost22.jpg'),
(5, 'https://example.com/images/sonyheadphones.jpg'),
(6, 'https://example.com/images/nikeshirt.jpg');

-- Insert Colors
INSERT INTO color (name, hex_code) VALUES
('Red', '#FF0000'),
('Blue', '#0000FF'),
('Black', '#000000'),
('White', '#FFFFFF'),
('Green', '#00FF00');

-- Insert Size Categories
INSERT INTO size_category (name, description) VALUES
('Shoe Size', 'Standard shoe sizing'),
('Clothing Size', 'Apparel sizing standards'),
('Device Size', 'Device storage options');

-- Insert Size Options
INSERT INTO size_option (label, size_category_id) VALUES
('42', 1),
('43', 1),
('M', 2),
('L', 2),
('128GB', 3),
('256GB', 3);

-- Insert Product Variations
INSERT INTO product_variation (product_id, color_id, size_option_id) VALUES
(1, 3, 5), -- iPhone 14, Black, 128GB
(1, 4, 6), -- iPhone 14, White, 256GB
(2, 1, 1), -- Running Shoes, Red, 42
(2, 2, 2), -- Running Shoes, Blue, 43
(4, 3, 1), -- UltraBoost 22, Black, 42
(6, 5, 3); -- Nike Shirt, Green, M

-- Insert Product Items
INSERT INTO product_item (product_variation_id, sku, stock_quantity, price) VALUES
(1, 'SKU_IPHONE14_BLK_128', 25, 999.99),
(2, 'SKU_IPHONE14_WHT_256', 15, 1099.99),
(3, 'SKU_RUNSHOE_RED_42', 50, 120.00),
(4, 'SKU_RUNSHOE_BLUE_43', 40, 125.00),
(5, 'SKU_ULTRABOOST_BLK_42', 30, 180.00),
(6, 'SKU_NIKESHIRT_GREEN_M', 70, 45.00);

-- Insert Attribute Categories
INSERT INTO attribute_category (name) VALUES
('Technical Specifications'),
('Material Information'),
('Product Features');

-- Insert Attribute Types
INSERT INTO attribute_type (name, data_type) VALUES
('Processor', 'text'),
('Material', 'text'),
('Battery Life', 'text'),
('Water Resistance', 'boolean');

-- Insert Product Attributes
INSERT INTO product_attribute (product_id, attribute_category_id, attribute_type_id, name, value) VALUES
(1, 1, 1, 'Processor', 'A16 Bionic'),
(3, 1, 1, 'Processor', 'Snapdragon 8 Gen 2'),
(5, 1, 3, 'Battery Life', '30 hours'),
(2, 2, 2, 'Material', 'Synthetic Mesh'),
(4, 2, 2, 'Material', 'Primeknit Fabric'),
(6, 3, 4, 'Water Resistance', 'true');
