-- Initialization script for ShopApp Database
-- This script will only run on first container startup

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS ShopApp;
USE ShopApp;

-- Grant privileges to shopapp user
GRANT ALL PRIVILEGES ON ShopApp.* TO 'shopapp'@'%';
FLUSH PRIVILEGES;

-- Note: Tables will be auto-created by Hibernate when DDL_AUTO=update
-- If you have existing schema, you can add it here

-- Insert default roles
CREATE TABLE IF NOT EXISTS roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(350) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO roles (name) VALUES ('USER');
INSERT IGNORE INTO roles (name) VALUES ('ADMIN');

-- Insert sample categories (optional)
CREATE TABLE IF NOT EXISTS categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO categories (name) VALUES
    ('Điện thoại'),
    ('Laptop'),
    ('Phụ kiện'),
    ('Tablet'),
    ('Smartwatch');

-- Create default admin user (password: admin123)
-- Note: You should change this password after first login
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    phone_number VARCHAR(10) UNIQUE NOT NULL,
    address VARCHAR(200),
    password VARCHAR(200) NOT NULL,
    active BOOLEAN DEFAULT TRUE,
    date_of_birth DATE,
    facebook_account_id INT DEFAULT 0,
    google_account_id INT DEFAULT 0,
    role_id BIGINT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Password: admin123 (BCrypt hash)
INSERT IGNORE INTO users (full_name, phone_number, address, password, active, role_id)
VALUES (
    'Administrator',
    '0123456789',
    'Ha Noi, Vietnam',
    '$2a$10$7fKYj7O8J/LXZ8xE6pqZCO5rJGgZNWxWXY3nZ9K5L7Y5qE8x8F8Gi',
    TRUE,
    (SELECT id FROM roles WHERE name = 'ADMIN')
);

COMMIT;
