-- PostgreSQL Init Script for Render
-- Run this after first deployment via Render Shell

-- Insert default roles
INSERT INTO roles (id, name) VALUES (1, 'USER') ON CONFLICT DO NOTHING;
INSERT INTO roles (id, name) VALUES (2, 'ADMIN') ON CONFLICT DO NOTHING;

-- Insert categories
INSERT INTO categories (id, name) VALUES
    (1, 'Điện thoại'),
    (2, 'Laptop'),
    (3, 'Phụ kiện'),
    (4, 'Tablet'),
    (5, 'Smartwatch')
ON CONFLICT DO NOTHING;

-- Admin user (password: admin123)
-- BCrypt hash for 'admin123'
INSERT INTO users (fullname, phone_number, address, password, is_active, role_id)
VALUES (
    'Administrator',
    '0123456789',
    'Ha Noi, Vietnam',
    '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrxGI0gG0h6s6wMJx0R6T.E4V1WNTC',
    TRUE,
    2
) ON CONFLICT (phone_number) DO NOTHING;
