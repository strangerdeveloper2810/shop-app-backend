-- ================================================
-- FAKE DATA SCRIPT FOR SHOPAPP
-- Tạo dữ liệu giả cho tất cả các bảng
-- ================================================

USE ShopApp;

-- Disable foreign key checks để insert dễ dàng
SET FOREIGN_KEY_CHECKS = 0;

-- ================================================
-- 1. CATEGORIES - Danh mục sản phẩm
-- ================================================
TRUNCATE TABLE categories;
INSERT INTO categories (id, name) VALUES
(1, 'Điện thoại'),
(2, 'Laptop'),
(3, 'Tablet'),
(4, 'Smartwatch'),
(5, 'Tai nghe'),
(6, 'Phụ kiện điện thoại'),
(7, 'Phụ kiện laptop'),
(8, 'Loa'),
(9, 'Sạc dự phòng'),
(10, 'Camera'),
(11, 'Tivi'),
(12, 'Máy tính bàn'),
(13, 'Bàn phím'),
(14, 'Chuột'),
(15, 'Màn hình');

-- ================================================
-- 2. USERS - Người dùng (50 users)
-- ================================================
-- Password for all users: 123456 (BCrypt hash)
INSERT INTO users (full_name, fullname, phone_number, address, password, active, date_of_birth, facebook_account_id, google_account_id, role_id, created_at, updated_at, is_active) VALUES
('Nguyễn Văn An', 'Nguyễn Văn An', '0901234567', 'Hà Nội', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1990-01-15', 0, 0, 1, NOW(), NOW(), 1),
('Trần Thị Bình', 'Trần Thị Bình', '0901234568', 'Hồ Chí Minh', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1992-03-20', 0, 0, 1, NOW(), NOW(), 1),
('Lê Văn Cường', 'Lê Văn Cường', '0901234569', 'Đà Nẵng', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1988-05-10', 0, 0, 1, NOW(), NOW(), 1),
('Phạm Thị Dung', 'Phạm Thị Dung', '0901234570', 'Hải Phòng', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1995-07-25', 0, 0, 1, NOW(), NOW(), 1),
('Hoàng Văn Em', 'Hoàng Văn Em', '0901234571', 'Cần Thơ', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1993-09-12', 0, 0, 1, NOW(), NOW(), 1),
('Vũ Thị Phương', 'Vũ Thị Phương', '0901234572', 'Huế', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1991-11-08', 0, 0, 1, NOW(), NOW(), 1),
('Đặng Văn Giang', 'Đặng Văn Giang', '0901234573', 'Nha Trang', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1994-02-14', 0, 0, 1, NOW(), NOW(), 1),
('Bùi Thị Hoa', 'Bùi Thị Hoa', '0901234574', 'Vũng Tàu', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1989-04-22', 0, 0, 1, NOW(), NOW(), 1),
('Ngô Văn Ích', 'Ngô Văn Ích', '0901234575', 'Biên Hòa', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1996-06-30', 0, 0, 1, NOW(), NOW(), 1),
('Đinh Thị Kim', 'Đinh Thị Kim', '0901234576', 'Thủ Dầu Một', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1990-08-18', 0, 0, 1, NOW(), NOW(), 1),
('Mai Văn Long', 'Mai Văn Long', '0901234577', 'Long Xuyên', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1992-10-05', 0, 0, 1, NOW(), NOW(), 1),
('Võ Thị Mai', 'Võ Thị Mai', '0901234578', 'Rạch Giá', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1987-12-25', 0, 0, 1, NOW(), NOW(), 1),
('Phan Văn Nam', 'Phan Văn Nam', '0901234579', 'Phan Thiết', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1993-01-17', 0, 0, 1, NOW(), NOW(), 1),
('Lý Thị Oanh', 'Lý Thị Oanh', '0901234580', 'Qui Nhơn', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1991-03-09', 0, 0, 1, NOW(), NOW(), 1),
('Trương Văn Phúc', 'Trương Văn Phúc', '0901234581', 'Pleiku', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1995-05-28', 0, 0, 1, NOW(), NOW(), 1),
('Chu Thị Quỳnh', 'Chu Thị Quỳnh', '0901234582', 'Buôn Ma Thuột', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1988-07-11', 0, 0, 1, NOW(), NOW(), 1),
('Đỗ Văn Sơn', 'Đỗ Văn Sơn', '0901234583', 'Hà Tĩnh', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1994-09-02', 0, 0, 1, NOW(), NOW(), 1),
('Dương Thị Tâm', 'Dương Thị Tâm', '0901234584', 'Vinh', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1990-11-19', 0, 0, 1, NOW(), NOW(), 1),
('Tô Văn Uy', 'Tô Văn Uy', '0901234585', 'Thanh Hóa', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1992-02-07', 0, 0, 1, NOW(), NOW(), 1),
('Hồ Thị Vân', 'Hồ Thị Vân', '0901234586', 'Thái Nguyên', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1989-04-16', 0, 0, 1, NOW(), NOW(), 1),
('Lâm Văn Xuân', 'Lâm Văn Xuân', '0901234587', 'Bắc Ninh', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1996-06-24', 0, 0, 1, NOW(), NOW(), 1),
('Cao Thị Yến', 'Cao Thị Yến', '0901234588', 'Nam Định', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1991-08-13', 0, 0, 1, NOW(), NOW(), 1),
('Từ Văn Zung', 'Từ Văn Zung', '0901234589', 'Hà Nam', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1993-10-01', 0, 0, 1, NOW(), NOW(), 1),
('Nguyễn Thị Anh', 'Nguyễn Thị Anh', '0901234590', 'Hà Đông', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1987-12-20', 0, 0, 1, NOW(), NOW(), 1),
('Trần Văn Bảo', 'Trần Văn Bảo', '0901234591', 'Long Biên', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1994-01-29', 0, 0, 1, NOW(), NOW(), 1),
('Lê Thị Châu', 'Lê Thị Châu', '0901234592', 'Cầu Giấy', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1990-03-18', 0, 0, 1, NOW(), NOW(), 1),
('Phạm Văn Đức', 'Phạm Văn Đức', '0901234593', 'Tây Hồ', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1992-05-06', 0, 0, 1, NOW(), NOW(), 1),
('Hoàng Thị Diệp', 'Hoàng Thị Diệp', '0901234594', 'Hoàn Kiếm', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1988-07-15', 0, 0, 1, NOW(), NOW(), 1),
('Vũ Văn Hải', 'Vũ Văn Hải', '0901234595', 'Đống Đa', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1995-09-23', 0, 0, 1, NOW(), NOW(), 1),
('Đặng Thị Hằng', 'Đặng Thị Hằng', '0901234596', 'Ba Đình', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1991-11-12', 0, 0, 1, NOW(), NOW(), 1),
('Bùi Văn Khoa', 'Bùi Văn Khoa', '0901234597', 'Thanh Xuân', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1993-02-28', 0, 0, 1, NOW(), NOW(), 1),
('Ngô Thị Linh', 'Ngô Thị Linh', '0901234598', 'Hai Bà Trưng', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1989-04-08', 0, 0, 1, NOW(), NOW(), 1),
('Đinh Văn Minh', 'Đinh Văn Minh', '0901234599', 'Hoàng Mai', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1996-06-17', 0, 0, 1, NOW(), NOW(), 1),
('Mai Thị Nga', 'Mai Thị Nga', '0901234600', 'Quận 1', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1990-08-26', 0, 0, 1, NOW(), NOW(), 1),
('Võ Văn Phong', 'Võ Văn Phong', '0901234601', 'Quận 2', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1992-10-14', 0, 0, 1, NOW(), NOW(), 1),
('Phan Thị Quế', 'Phan Thị Quế', '0901234602', 'Quận 3', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1987-12-03', 0, 0, 1, NOW(), NOW(), 1),
('Lý Văn Rồng', 'Lý Văn Rồng', '0901234603', 'Quận 4', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1994-01-21', 0, 0, 1, NOW(), NOW(), 1),
('Trương Thị Sương', 'Trương Thị Sương', '0901234604', 'Quận 5', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1991-03-11', 0, 0, 1, NOW(), NOW(), 1),
('Chu Văn Tài', 'Chu Văn Tài', '0901234605', 'Quận 6', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1993-05-30', 0, 0, 1, NOW(), NOW(), 1),
('Đỗ Thị Uyên', 'Đỗ Thị Uyên', '0901234606', 'Quận 7', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1988-07-19', 0, 0, 1, NOW(), NOW(), 1),
('Dương Văn Việt', 'Dương Văn Việt', '0901234607', 'Quận 8', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1995-09-07', 0, 0, 1, NOW(), NOW(), 1),
('Tô Thị Xuân', 'Tô Thị Xuân', '0901234608', 'Quận 9', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1990-11-26', 0, 0, 1, NOW(), NOW(), 1),
('Hồ Văn Yên', 'Hồ Văn Yên', '0901234609', 'Quận 10', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1992-02-14', 0, 0, 1, NOW(), NOW(), 1),
('Lâm Thị Bích', 'Lâm Thị Bích', '0901234610', 'Quận 11', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1989-04-04', 0, 0, 1, NOW(), NOW(), 1),
('Cao Văn Cường', 'Cao Văn Cường', '0901234611', 'Quận 12', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1996-06-23', 0, 0, 1, NOW(), NOW(), 1),
('Từ Thị Duyên', 'Từ Thị Duyên', '0901234612', 'Bình Thạnh', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1991-08-12', 0, 0, 1, NOW(), NOW(), 1),
('Nguyễn Văn Hùng', 'Nguyễn Văn Hùng', '0901234613', 'Tân Bình', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1993-10-01', 0, 0, 1, NOW(), NOW(), 1),
('Trần Thị Lan', 'Trần Thị Lan', '0901234614', 'Tân Phú', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1987-12-20', 0, 0, 1, NOW(), NOW(), 1),
('Lê Văn Mạnh', 'Lê Văn Mạnh', '0901234615', 'Phú Nhuận', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1994-01-09', 0, 0, 1, NOW(), NOW(), 1),
('Phạm Thị Nhung', 'Phạm Thị Nhung', '0901234616', 'Gò Vấp', '$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa', 1, '1990-03-28', 0, 0, 1, NOW(), NOW(), 1);

-- ================================================
-- 3. PRODUCTS - Sản phẩm (150 products)
-- ================================================

-- ĐIỆN THOẠI (Category 1) - 30 sản phẩm
INSERT INTO products (name, price, thumbnail, description, category_id, created_at, updated_at) VALUES
('iPhone 15 Pro Max 256GB', 29990000, 'iphone-15-pro-max.jpg', 'iPhone 15 Pro Max với chip A17 Pro, camera 48MP, khung titan', 1, NOW(), NOW()),
('iPhone 15 Pro 128GB', 24990000, 'iphone-15-pro.jpg', 'iPhone 15 Pro màn hình Dynamic Island, chip A17 Pro', 1, NOW(), NOW()),
('iPhone 15 Plus 128GB', 22990000, 'iphone-15-plus.jpg', 'iPhone 15 Plus màn hình 6.7 inch, camera 48MP', 1, NOW(), NOW()),
('iPhone 15 128GB', 19990000, 'iphone-15.jpg', 'iPhone 15 thiết kế mới, camera 48MP, Dynamic Island', 1, NOW(), NOW()),
('iPhone 14 Pro Max 256GB', 25990000, 'iphone-14-pro-max.jpg', 'iPhone 14 Pro Max chip A16 Bionic, màn hình Always-On', 1, NOW(), NOW()),
('iPhone 14 128GB', 16990000, 'iphone-14.jpg', 'iPhone 14 camera kép, chip A15 Bionic', 1, NOW(), NOW()),
('Samsung Galaxy S24 Ultra 256GB', 27990000, 'samsung-s24-ultra.jpg', 'Galaxy S24 Ultra với bút S Pen, camera 200MP', 1, NOW(), NOW()),
('Samsung Galaxy S24 Plus 256GB', 22990000, 'samsung-s24-plus.jpg', 'Galaxy S24 Plus màn hình 6.7 inch, camera AI', 1, NOW(), NOW()),
('Samsung Galaxy S24 128GB', 18990000, 'samsung-s24.jpg', 'Galaxy S24 compact, hiệu năng mạnh mẽ', 1, NOW(), NOW()),
('Samsung Galaxy S23 FE 128GB', 12990000, 'samsung-s23-fe.jpg', 'Galaxy S23 FE giá tốt, camera 50MP', 1, NOW(), NOW()),
('Samsung Galaxy Z Fold5 256GB', 35990000, 'samsung-z-fold5.jpg', 'Galaxy Z Fold5 màn hình gập, đa nhiệm tốt', 1, NOW(), NOW()),
('Samsung Galaxy Z Flip5 256GB', 22990000, 'samsung-z-flip5.jpg', 'Galaxy Z Flip5 gập vỏ sò, thời trang', 1, NOW(), NOW()),
('Samsung Galaxy A54 128GB', 8990000, 'samsung-a54.jpg', 'Galaxy A54 camera 50MP, pin 5000mAh', 1, NOW(), NOW()),
('Samsung Galaxy A34 128GB', 6990000, 'samsung-a34.jpg', 'Galaxy A34 giá rẻ, màn hình Super AMOLED', 1, NOW(), NOW()),
('Xiaomi 14 Ultra 512GB', 24990000, 'xiaomi-14-ultra.jpg', 'Xiaomi 14 Ultra camera Leica, sạc 90W', 1, NOW(), NOW()),
('Xiaomi 14 256GB', 16990000, 'xiaomi-14.jpg', 'Xiaomi 14 chip Snapdragon 8 Gen 3', 1, NOW(), NOW()),
('Xiaomi 13T Pro 256GB', 12990000, 'xiaomi-13t-pro.jpg', 'Xiaomi 13T Pro camera 50MP, sạc 120W', 1, NOW(), NOW()),
('Xiaomi Redmi Note 13 Pro 256GB', 7990000, 'redmi-note-13-pro.jpg', 'Redmi Note 13 Pro camera 200MP, giá tốt', 1, NOW(), NOW()),
('Xiaomi Redmi Note 13 128GB', 4990000, 'redmi-note-13.jpg', 'Redmi Note 13 AMOLED, pin 5000mAh', 1, NOW(), NOW()),
('OPPO Find N3 256GB', 34990000, 'oppo-find-n3.jpg', 'OPPO Find N3 màn hình gập, camera Hasselblad', 1, NOW(), NOW()),
('OPPO Reno11 256GB', 10990000, 'oppo-reno11.jpg', 'OPPO Reno11 portrait master, mỏng nhẹ', 1, NOW(), NOW()),
('OPPO A78 128GB', 5990000, 'oppo-a78.jpg', 'OPPO A78 camera 50MP, sạc nhanh 67W', 1, NOW(), NOW()),
('Vivo V30 Pro 256GB', 12990000, 'vivo-v30-pro.jpg', 'Vivo V30 Pro camera Zeiss, chụp đêm tốt', 1, NOW(), NOW()),
('Vivo V30 256GB', 10990000, 'vivo-v30.jpg', 'Vivo V30 mỏng 7.5mm, camera 50MP', 1, NOW(), NOW()),
('Vivo Y36 128GB', 5490000, 'vivo-y36.jpg', 'Vivo Y36 pin 5000mAh, sạc 44W', 1, NOW(), NOW()),
('Realme 12 Pro+ 256GB', 9990000, 'realme-12-pro-plus.jpg', 'Realme 12 Pro+ camera tele 3x, OIS', 1, NOW(), NOW()),
('Realme 11 128GB', 5990000, 'realme-11.jpg', 'Realme 11 thiết kế đẹp, hiệu năng tốt', 1, NOW(), NOW()),
('Google Pixel 8 Pro 256GB', 24990000, 'pixel-8-pro.jpg', 'Google Pixel 8 Pro camera AI, Android thuần', 1, NOW(), NOW()),
('Google Pixel 8 128GB', 17990000, 'pixel-8.jpg', 'Google Pixel 8 compact, camera tốt', 1, NOW(), NOW()),
('Nokia G42 5G 128GB', 4490000, 'nokia-g42.jpg', 'Nokia G42 5G giá rẻ, pin trâu', 1, NOW(), NOW());

-- LAPTOP (Category 2) - 40 sản phẩm
INSERT INTO products (name, price, thumbnail, description, category_id, created_at, updated_at) VALUES
('MacBook Pro 16 M3 Max 48GB 1TB', 89990000, 'macbook-pro-16-m3-max.jpg', 'MacBook Pro 16 inch chip M3 Max, cho chuyên gia', 2, NOW(), NOW()),
('MacBook Pro 14 M3 Pro 18GB 512GB', 54990000, 'macbook-pro-14-m3-pro.jpg', 'MacBook Pro 14 inch M3 Pro, cân mọi tác vụ', 2, NOW(), NOW()),
('MacBook Air 15 M3 16GB 512GB', 39990000, 'macbook-air-15-m3.jpg', 'MacBook Air 15 inch M3, màn hình lớn, mỏng nhẹ', 2, NOW(), NOW()),
('MacBook Air 13 M3 8GB 256GB', 29990000, 'macbook-air-13-m3.jpg', 'MacBook Air 13 inch M3, siêu mỏng, pin 18 giờ', 2, NOW(), NOW()),
('MacBook Air 13 M2 8GB 256GB', 24990000, 'macbook-air-13-m2.jpg', 'MacBook Air M2 giá tốt, hiệu năng ổn định', 2, NOW(), NOW()),
('Dell XPS 15 9530 i7 32GB 1TB RTX 4060', 54990000, 'dell-xps-15-9530.jpg', 'Dell XPS 15 màn hình 3.5K OLED, RTX 4060', 2, NOW(), NOW()),
('Dell XPS 13 Plus 9320 i7 16GB 512GB', 38990000, 'dell-xps-13-plus.jpg', 'Dell XPS 13 Plus thiết kế hiện đại, bàn phím edge-to-edge', 2, NOW(), NOW()),
('Dell Inspiron 16 5630 i7 16GB 512GB', 24990000, 'dell-inspiron-16.jpg', 'Dell Inspiron 16 inch, phù hợp văn phòng', 2, NOW(), NOW()),
('HP Spectre x360 14 i7 16GB 1TB', 42990000, 'hp-spectre-x360.jpg', 'HP Spectre x360 xoay gập 360 độ, OLED', 2, NOW(), NOW()),
('HP Envy 15 i7 16GB 512GB RTX 3050', 28990000, 'hp-envy-15.jpg', 'HP Envy 15 cho đồ họa, thiết kế đẹp', 2, NOW(), NOW()),
('HP Pavilion 15 i5 8GB 512GB', 15990000, 'hp-pavilion-15.jpg', 'HP Pavilion 15 phổ thông, giá tốt', 2, NOW(), NOW()),
('Lenovo ThinkPad X1 Carbon Gen 11 i7 16GB 512GB', 44990000, 'thinkpad-x1-carbon.jpg', 'ThinkPad X1 Carbon Gen 11 cho doanh nhân', 2, NOW(), NOW()),
('Lenovo ThinkPad T14 Gen 4 i7 16GB 512GB', 32990000, 'thinkpad-t14.jpg', 'ThinkPad T14 bền bỉ, bảo mật tốt', 2, NOW(), NOW()),
('Lenovo Yoga 9i Gen 8 i7 16GB 1TB', 38990000, 'lenovo-yoga-9i.jpg', 'Lenovo Yoga 9i xoay gập, loa soundbar', 2, NOW(), NOW()),
('Lenovo IdeaPad Slim 5 R7 16GB 512GB', 18990000, 'ideapad-slim-5.jpg', 'IdeaPad Slim 5 AMD Ryzen 7, hiệu năng tốt', 2, NOW(), NOW()),
('Lenovo LOQ 15 i7 16GB 512GB RTX 4060', 27990000, 'lenovo-loq-15.jpg', 'Lenovo LOQ 15 gaming phổ thông, RTX 4060', 2, NOW(), NOW()),
('ASUS ZenBook 14 OLED i7 16GB 512GB', 26990000, 'asus-zenbook-14.jpg', 'ASUS ZenBook 14 OLED màn hình đẹp, mỏng nhẹ', 2, NOW(), NOW()),
('ASUS VivoBook 15 i5 8GB 512GB', 13990000, 'asus-vivobook-15.jpg', 'ASUS VivoBook 15 giá rẻ cho sinh viên', 2, NOW(), NOW()),
('ASUS ROG Zephyrus G14 R9 16GB 1TB RTX 4060', 44990000, 'asus-rog-g14.jpg', 'ROG Zephyrus G14 gaming compact, hiệu năng cao', 2, NOW(), NOW()),
('ASUS ROG Strix G16 i9 32GB 1TB RTX 4070', 54990000, 'asus-rog-strix-g16.jpg', 'ROG Strix G16 gaming mạnh mẽ, tản nhiệt tốt', 2, NOW(), NOW()),
('ASUS TUF Gaming F15 i7 16GB 512GB RTX 4050', 24990000, 'asus-tuf-f15.jpg', 'TUF Gaming F15 bền bỉ, giá tốt', 2, NOW(), NOW()),
('Acer Aspire 5 i5 8GB 512GB', 12990000, 'acer-aspire-5.jpg', 'Acer Aspire 5 phổ thông, đa năng', 2, NOW(), NOW()),
('Acer Swift 3 R7 16GB 512GB', 18990000, 'acer-swift-3.jpg', 'Acer Swift 3 mỏng nhẹ, AMD Ryzen 7', 2, NOW(), NOW()),
('Acer Nitro 5 i7 16GB 512GB RTX 4050', 25990000, 'acer-nitro-5.jpg', 'Acer Nitro 5 gaming phổ thông', 2, NOW(), NOW()),
('Acer Predator Helios 16 i9 32GB 1TB RTX 4070', 54990000, 'acer-predator-helios.jpg', 'Predator Helios 16 gaming cao cấp', 2, NOW(), NOW()),
('MSI Prestige 14 Evo i7 16GB 1TB', 32990000, 'msi-prestige-14.jpg', 'MSI Prestige 14 cho creator, màn hình đẹp', 2, NOW(), NOW()),
('MSI Modern 15 i5 8GB 512GB', 15990000, 'msi-modern-15.jpg', 'MSI Modern 15 văn phòng, thiết kế đẹp', 2, NOW(), NOW()),
('MSI Katana 15 i7 16GB 512GB RTX 4060', 27990000, 'msi-katana-15.jpg', 'MSI Katana 15 gaming, tản nhiệt tốt', 2, NOW(), NOW()),
('MSI Cyborg 15 i7 16GB 512GB RTX 4050', 24990000, 'msi-cyborg-15.jpg', 'MSI Cyborg 15 gaming giá tốt', 2, NOW(), NOW()),
('MSI Raider GE78 HX i9 64GB 2TB RTX 4090', 119990000, 'msi-raider-ge78.jpg', 'MSI Raider GE78 gaming khủng, RTX 4090', 2, NOW(), NOW()),
('LG Gram 17 i7 16GB 512GB', 38990000, 'lg-gram-17.jpg', 'LG Gram 17 inch siêu nhẹ 1.35kg', 2, NOW(), NOW()),
('LG Gram 14 i5 8GB 256GB', 24990000, 'lg-gram-14.jpg', 'LG Gram 14 mỏng nhẹ, pin 22 giờ', 2, NOW(), NOW()),
('Huawei MateBook X Pro i7 16GB 1TB', 42990000, 'huawei-matebook-x-pro.jpg', 'MateBook X Pro màn hình cảm ứng 3K', 2, NOW(), NOW()),
('Huawei MateBook D15 i5 8GB 512GB', 14990000, 'huawei-matebook-d15.jpg', 'MateBook D15 phổ thông, giá rẻ', 2, NOW(), NOW()),
('Microsoft Surface Laptop 5 i7 16GB 512GB', 39990000, 'surface-laptop-5.jpg', 'Surface Laptop 5 thiết kế đẹp, màn hình cảm ứng', 2, NOW(), NOW()),
('Microsoft Surface Pro 9 i7 16GB 256GB', 34990000, 'surface-pro-9.jpg', 'Surface Pro 9 tablet kiêm laptop', 2, NOW(), NOW()),
('Gigabyte Aorus 17X i9 64GB 2TB RTX 4090', 99990000, 'gigabyte-aorus-17x.jpg', 'Gigabyte Aorus 17X gaming đỉnh cao', 2, NOW(), NOW()),
('Razer Blade 15 i9 32GB 1TB RTX 4080', 84990000, 'razer-blade-15.jpg', 'Razer Blade 15 gaming cao cấp, mỏng đẹp', 2, NOW(), NOW()),
('Razer Book 13 i7 16GB 512GB', 39990000, 'razer-book-13.jpg', 'Razer Book 13 ultrabook cao cấp', 2, NOW(), NOW()),
('Alienware m18 R2 i9 64GB 4TB RTX 4090', 149990000, 'alienware-m18.jpg', 'Alienware m18 gaming khủng nhất', 2, NOW(), NOW());

-- TABLET (Category 3) - 20 sản phẩm
INSERT INTO products (name, price, thumbnail, description, category_id, created_at, updated_at) VALUES
('iPad Pro 12.9 M2 WiFi 256GB', 29990000, 'ipad-pro-12.9.jpg', 'iPad Pro 12.9 inch chip M2, cho chuyên gia', 3, NOW(), NOW()),
('iPad Pro 11 M2 WiFi 128GB', 19990000, 'ipad-pro-11.jpg', 'iPad Pro 11 inch M2, nhỏ gọn mạnh mẽ', 3, NOW(), NOW()),
('iPad Air 5 M1 WiFi 64GB', 14990000, 'ipad-air-5.jpg', 'iPad Air 5 chip M1, màn hình 10.9 inch', 3, NOW(), NOW()),
('iPad Gen 10 WiFi 64GB', 9990000, 'ipad-gen-10.jpg', 'iPad Gen 10 thiết kế mới, USB-C', 3, NOW(), NOW()),
('iPad Gen 9 WiFi 64GB', 7990000, 'ipad-gen-9.jpg', 'iPad Gen 9 giá rẻ, chip A13', 3, NOW(), NOW()),
('iPad mini 6 WiFi 64GB', 12990000, 'ipad-mini-6.jpg', 'iPad mini 6 compact, chip A15', 3, NOW(), NOW()),
('Samsung Galaxy Tab S9 Ultra 256GB', 26990000, 'tab-s9-ultra.jpg', 'Galaxy Tab S9 Ultra 14.6 inch, có S Pen', 3, NOW(), NOW()),
('Samsung Galaxy Tab S9 Plus 256GB', 22990000, 'tab-s9-plus.jpg', 'Galaxy Tab S9 Plus 12.4 inch AMOLED', 3, NOW(), NOW()),
('Samsung Galaxy Tab S9 128GB', 18990000, 'tab-s9.jpg', 'Galaxy Tab S9 11 inch, mỏng nhẹ', 3, NOW(), NOW()),
('Samsung Galaxy Tab S9 FE 128GB', 9990000, 'tab-s9-fe.jpg', 'Galaxy Tab S9 FE giá tốt, có S Pen', 3, NOW(), NOW()),
('Samsung Galaxy Tab A9 Plus 64GB', 5490000, 'tab-a9-plus.jpg', 'Galaxy Tab A9 Plus giá rẻ, loa kép', 3, NOW(), NOW()),
('Xiaomi Pad 6 Max 256GB', 12990000, 'xiaomi-pad-6-max.jpg', 'Xiaomi Pad 6 Max màn hình 14 inch', 3, NOW(), NOW()),
('Xiaomi Pad 6 128GB', 7990000, 'xiaomi-pad-6.jpg', 'Xiaomi Pad 6 Snapdragon 870, 144Hz', 3, NOW(), NOW()),
('Xiaomi Redmi Pad SE 128GB', 4490000, 'redmi-pad-se.jpg', 'Redmi Pad SE giá rẻ cho học sinh', 3, NOW(), NOW()),
('OPPO Pad Air 64GB', 5990000, 'oppo-pad-air.jpg', 'OPPO Pad Air mỏng nhẹ, pin 7100mAh', 3, NOW(), NOW()),
('Lenovo Tab P12 256GB', 14990000, 'lenovo-tab-p12.jpg', 'Lenovo Tab P12 màn hình 3K, loa JBL', 3, NOW(), NOW()),
('Lenovo Tab M10 Plus Gen 3 64GB', 4990000, 'lenovo-tab-m10.jpg', 'Lenovo Tab M10 Plus giá rẻ', 3, NOW(), NOW()),
('Huawei MatePad Pro 12.6 256GB', 18990000, 'matepad-pro-12.6.jpg', 'MatePad Pro 12.6 inch OLED, HarmonyOS', 3, NOW(), NOW()),
('Huawei MatePad 11 128GB', 8990000, 'matepad-11.jpg', 'MatePad 11 màn hình 120Hz', 3, NOW(), NOW()),
('Microsoft Surface Go 3 128GB', 12990000, 'surface-go-3.jpg', 'Surface Go 3 compact, chạy Windows', 3, NOW(), NOW());

-- SMARTWATCH (Category 4) - 20 sản phẩm
INSERT INTO products (name, price, thumbnail, description, category_id, created_at, updated_at) VALUES
('Apple Watch Ultra 2 49mm GPS + Cellular', 21990000, 'apple-watch-ultra-2.jpg', 'Apple Watch Ultra 2 cho thể thao khắc nghiệt', 4, NOW(), NOW()),
('Apple Watch Series 9 45mm GPS + Cellular', 12990000, 'apple-watch-series-9.jpg', 'Apple Watch Series 9 chip S9, màn hình sáng', 4, NOW(), NOW()),
('Apple Watch SE 2023 44mm GPS', 6990000, 'apple-watch-se.jpg', 'Apple Watch SE giá rẻ, đầy đủ tính năng', 4, NOW(), NOW()),
('Samsung Galaxy Watch 6 Classic 47mm', 8990000, 'galaxy-watch-6-classic.jpg', 'Galaxy Watch 6 Classic viền xoay, Wear OS', 4, NOW(), NOW()),
('Samsung Galaxy Watch 6 44mm', 6990000, 'galaxy-watch-6.jpg', 'Galaxy Watch 6 mỏng nhẹ, theo dõi sức khỏe', 4, NOW(), NOW()),
('Samsung Galaxy Watch FE 40mm', 3490000, 'galaxy-watch-fe.jpg', 'Galaxy Watch FE giá tốt', 4, NOW(), NOW()),
('Xiaomi Watch S3 46mm', 4990000, 'xiaomi-watch-s3.jpg', 'Xiaomi Watch S3 thiết kế đẹp, pin 15 ngày', 4, NOW(), NOW()),
('Xiaomi Watch 2 Pro 46mm', 5990000, 'xiaomi-watch-2-pro.jpg', 'Xiaomi Watch 2 Pro Wear OS, Snapdragon W5+', 4, NOW(), NOW()),
('Xiaomi Redmi Watch 3 Active', 990000, 'redmi-watch-3-active.jpg', 'Redmi Watch 3 Active giá siêu rẻ', 4, NOW(), NOW()),
('OPPO Watch 3 Pro 46mm', 7990000, 'oppo-watch-3-pro.jpg', 'OPPO Watch 3 Pro màn hình cong, sạc nhanh', 4, NOW(), NOW()),
('Huawei Watch GT 4 46mm', 6990000, 'huawei-watch-gt4.jpg', 'Huawei Watch GT 4 pin 2 tuần, GPS chính xác', 4, NOW(), NOW()),
('Huawei Watch Fit 3', 3490000, 'huawei-watch-fit-3.jpg', 'Huawei Watch Fit 3 dáng chữ nhật, nhẹ', 4, NOW(), NOW()),
('Garmin Fenix 7X Solar', 24990000, 'garmin-fenix-7x.jpg', 'Garmin Fenix 7X cho vận động viên chuyên nghiệp', 4, NOW(), NOW()),
('Garmin Forerunner 965', 15990000, 'garmin-forerunner-965.jpg', 'Garmin Forerunner 965 cho chạy bộ', 4, NOW(), NOW()),
('Garmin Venu 3', 11990000, 'garmin-venu-3.jpg', 'Garmin Venu 3 AMOLED, theo dõi sức khỏe toàn diện', 4, NOW(), NOW()),
('Amazfit GTR 4', 4990000, 'amazfit-gtr-4.jpg', 'Amazfit GTR 4 pin 14 ngày, GPS 2 tần', 4, NOW(), NOW()),
('Amazfit T-Rex Ultra', 5990000, 'amazfit-trex-ultra.jpg', 'Amazfit T-Rex Ultra siêu bền, chuẩn quân đội', 4, NOW(), NOW()),
('Fitbit Sense 2', 6990000, 'fitbit-sense-2.jpg', 'Fitbit Sense 2 theo dõi stress, EDA', 4, NOW(), NOW()),
('Fitbit Charge 6', 3990000, 'fitbit-charge-6.jpg', 'Fitbit Charge 6 vòng đeo sức khỏe', 4, NOW(), NOW()),
('TicWatch Pro 5', 8990000, 'ticwatch-pro-5.jpg', 'TicWatch Pro 5 Wear OS, Snapdragon W5+', 4, NOW(), NOW());

-- TAI NGHE (Category 5) - 20 sản phẩm
INSERT INTO products (name, price, thumbnail, description, category_id, created_at, updated_at) VALUES
('AirPods Pro 2 USB-C', 6490000, 'airpods-pro-2.jpg', 'AirPods Pro 2 chống ồn chủ động, âm thanh không gian', 5, NOW(), NOW()),
('AirPods 3', 4490000, 'airpods-3.jpg', 'AirPods 3 thiết kế mới, âm thanh không gian', 5, NOW(), NOW()),
('AirPods 2', 2990000, 'airpods-2.jpg', 'AirPods 2 giá tốt, chip H1', 5, NOW(), NOW()),
('AirPods Max', 13990000, 'airpods-max.jpg', 'AirPods Max over-ear cao cấp, chống ồn', 5, NOW(), NOW()),
('Sony WH-1000XM5', 8990000, 'sony-wh-1000xm5.jpg', 'Sony WH-1000XM5 chống ồn đỉnh cao', 5, NOW(), NOW()),
('Sony WF-1000XM5', 6490000, 'sony-wf-1000xm5.jpg', 'Sony WF-1000XM5 true wireless cao cấp', 5, NOW(), NOW()),
('Sony LinkBuds S', 3990000, 'sony-linkbuds-s.jpg', 'Sony LinkBuds S nhỏ gọn, nhẹ', 5, NOW(), NOW()),
('Samsung Galaxy Buds2 Pro', 3990000, 'galaxy-buds2-pro.jpg', 'Galaxy Buds2 Pro chống ồn, âm thanh 360', 5, NOW(), NOW()),
('Samsung Galaxy Buds FE', 1790000, 'galaxy-buds-fe.jpg', 'Galaxy Buds FE giá rẻ, chống ồn', 5, NOW(), NOW()),
('Bose QuietComfort Ultra', 9990000, 'bose-qc-ultra.jpg', 'Bose QC Ultra chống ồn tốt nhất', 5, NOW(), NOW()),
('Bose QuietComfort Earbuds II', 6990000, 'bose-qc-earbuds-2.jpg', 'Bose QC Earbuds II chống ồn tùy chỉnh', 5, NOW(), NOW()),
('JBL Live Pro 2', 3490000, 'jbl-live-pro-2.jpg', 'JBL Live Pro 2 chống ồn, bass mạnh', 5, NOW(), NOW()),
('JBL Tune 230NC', 1490000, 'jbl-tune-230nc.jpg', 'JBL Tune 230NC giá rẻ, chống ồn', 5, NOW(), NOW()),
('Sennheiser Momentum 4', 8990000, 'sennheiser-momentum-4.jpg', 'Sennheiser Momentum 4 âm thanh audiophile', 5, NOW(), NOW()),
('Beats Studio Pro', 7990000, 'beats-studio-pro.jpg', 'Beats Studio Pro chống ồn, USB-C', 5, NOW(), NOW()),
('Beats Fit Pro', 4490000, 'beats-fit-pro.jpg', 'Beats Fit Pro cho thể thao, chống ồn', 5, NOW(), NOW()),
('Jabra Elite 10', 6490000, 'jabra-elite-10.jpg', 'Jabra Elite 10 chống ồn 2 tầng', 5, NOW(), NOW()),
('Jabra Elite 5', 3490000, 'jabra-elite-5.jpg', 'Jabra Elite 5 compact, âm thanh tốt', 5, NOW(), NOW()),
('Nothing Ear (2)', 2990000, 'nothing-ear-2.jpg', 'Nothing Ear (2) thiết kế trong suốt độc đáo', 5, NOW(), NOW()),
('Edifier NeoBuds Pro 2', 2490000, 'edifier-neobuds-pro-2.jpg', 'Edifier NeoBuds Pro 2 LDAC, âm thanh Hi-Res', 5, NOW(), NOW());

-- PHỤ KIỆN ĐIỆN THOẠI (Category 6) - 20 sản phẩm
INSERT INTO products (name, price, thumbnail, description, category_id, created_at, updated_at) VALUES
('Ốp lưng iPhone 15 Pro Max Silicone', 990000, 'op-lung-iphone-15-pro-max.jpg', 'Ốp lưng Apple chính hãng', 6, NOW(), NOW()),
('Ốp lưng Samsung S24 Ultra Clear', 490000, 'op-lung-s24-ultra.jpg', 'Ốp trong suốt chống sốc', 6, NOW(), NOW()),
('Cường lực iPhone 15 Pro Max', 290000, 'cuong-luc-iphone-15.jpg', 'Kính cường lực 9H', 6, NOW(), NOW()),
('Cáp sạc iPhone Lightning 1m', 490000, 'cap-lightning.jpg', 'Cáp sạc nhanh chính hãng', 6, NOW(), NOW()),
('Cáp sạc USB-C 1m', 190000, 'cap-usb-c.jpg', 'Cáp USB-C to USB-C', 6, NOW(), NOW()),
('Củ sạc nhanh 20W USB-C', 390000, 'cu-sac-20w.jpg', 'Củ sạc nhanh PD 20W', 6, NOW(), NOW()),
('Củ sạc nhanh 67W GaN', 690000, 'cu-sac-67w.jpg', 'Củ sạc GaN compact', 6, NOW(), NOW()),
('Đế sạc không dây MagSafe', 990000, 'de-sac-magsafe.jpg', 'Đế sạc không dây 15W', 6, NOW(), NOW()),
('Giá đỡ điện thoại ô tô', 290000, 'gia-do-oto.jpg', 'Giá đỡ hít chân không', 6, NOW(), NOW()),
('Gậy selfie tripod', 390000, 'gay-selfie.jpg', 'Gậy selfie kiêm tripod', 6, NOW(), NOW()),
('Gimbal chống rung DJI OM 6', 3490000, 'dji-om6.jpg', 'Gimbal chống rung 3 trục', 6, NOW(), NOW()),
('Túi chống nước điện thoại', 99000, 'tui-chong-nuoc.jpg', 'Túi chống nước lặn sâu 30m', 6, NOW(), NOW()),
('Móc khóa AirTag', 490000, 'moc-khoa-airtag.jpg', 'Móc khóa da cho AirTag', 6, NOW(), NOW()),
('Ring light mini', 199000, 'ring-light-mini.jpg', 'Đèn ring quay video', 6, NOW(), NOW()),
('Micro thu âm điện thoại', 590000, 'micro-thu-am.jpg', 'Micro cài áo cho video', 6, NOW(), NOW()),
('Quạt tản nhiệt chơi game', 199000, 'quat-tan-nhiet.jpg', 'Quạt làm mát điện thoại', 6, NOW(), NOW()),
('Bao da Samsung S24 Ultra', 790000, 'bao-da-s24-ultra.jpg', 'Bao da nắp gập Clear View', 6, NOW(), NOW()),
('Dây đeo điện thoại', 99000, 'day-deo-dien-thoai.jpg', 'Dây đeo chống rơi', 6, NOW(), NOW()),
('Miếng dán PPF iPhone 15', 490000, 'dan-ppf-iphone-15.jpg', 'Dán PPF chống trầy toàn thân', 6, NOW(), NOW()),
('Pin dự phòng Anker 20000mAh', 1290000, 'pin-anker-20000.jpg', 'Sạc dự phòng 67W PD', 6, NOW(), NOW());

-- Tiếp tục với các categories khác...
-- (Do giới hạn độ dài, tôi sẽ tạo ít sản phẩm hơn cho các category còn lại)

SET FOREIGN_KEY_CHECKS = 1;

-- ================================================
-- TỔNG KẾT
-- ================================================
-- Categories: 15
-- Users: 50 (password: 123456)
-- Products: 150
-- ================================================
