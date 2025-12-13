-- Seed data - runs on startup when tables are empty

-- Roles
INSERT INTO roles (id, name) SELECT 1, 'USER' WHERE NOT EXISTS (SELECT 1 FROM roles WHERE id = 1);
INSERT INTO roles (id, name) SELECT 2, 'ADMIN' WHERE NOT EXISTS (SELECT 1 FROM roles WHERE id = 2);

-- Categories
INSERT INTO categories (id, name) SELECT 1, 'Điện thoại' WHERE NOT EXISTS (SELECT 1 FROM categories WHERE id = 1);
INSERT INTO categories (id, name) SELECT 2, 'Laptop' WHERE NOT EXISTS (SELECT 1 FROM categories WHERE id = 2);
INSERT INTO categories (id, name) SELECT 3, 'Phụ kiện' WHERE NOT EXISTS (SELECT 1 FROM categories WHERE id = 3);
INSERT INTO categories (id, name) SELECT 4, 'Tablet' WHERE NOT EXISTS (SELECT 1 FROM categories WHERE id = 4);
INSERT INTO categories (id, name) SELECT 5, 'Smartwatch' WHERE NOT EXISTS (SELECT 1 FROM categories WHERE id = 5);

-- Admin user (password: admin123)
INSERT INTO users (id, fullname, phone_number, address, password, is_active, role_id)
SELECT 1, 'Administrator', '0123456789', 'Ha Noi, Vietnam',
    '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrxGI0gG0h6s6wMJx0R6T.E4V1WNTC', TRUE, 2
WHERE NOT EXISTS (SELECT 1 FROM users WHERE phone_number = '0123456789');
