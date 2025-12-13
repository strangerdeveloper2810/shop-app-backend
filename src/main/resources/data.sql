-- Seed data - runs on startup (PostgreSQL syntax)

-- Roles
INSERT INTO roles (id, name) VALUES (1, 'USER') ON CONFLICT (id) DO NOTHING;
INSERT INTO roles (id, name) VALUES (2, 'ADMIN') ON CONFLICT (id) DO NOTHING;

-- Categories
INSERT INTO categories (id, name) VALUES (1, 'Dien thoai') ON CONFLICT (id) DO NOTHING;
INSERT INTO categories (id, name) VALUES (2, 'Laptop') ON CONFLICT (id) DO NOTHING;
INSERT INTO categories (id, name) VALUES (3, 'Phu kien') ON CONFLICT (id) DO NOTHING;
INSERT INTO categories (id, name) VALUES (4, 'Tablet') ON CONFLICT (id) DO NOTHING;
INSERT INTO categories (id, name) VALUES (5, 'Smartwatch') ON CONFLICT (id) DO NOTHING;

-- Admin user (password: 123456 - BCrypt encoded)
INSERT INTO users (id, fullname, phone_number, address, password, is_active, role_id, facebook_account_id, google_account_id)
VALUES (1, 'Administrator', '0123456789', 'Ha Noi, Vietnam',
    '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', true, 2, 0, 0)
ON CONFLICT (id) DO UPDATE SET
    facebook_account_id = 0,
    google_account_id = 0,
    password = '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa';
