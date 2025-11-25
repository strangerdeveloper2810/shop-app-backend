-- ================================================
-- FAKE DATA PART 3: PRODUCT_IMAGES
-- Tạo ảnh cho sản phẩm (mỗi sản phẩm 2-5 ảnh)
-- ================================================

USE ShopApp;

SET FOREIGN_KEY_CHECKS = 0;

-- ================================================
-- PRODUCT_IMAGES - Ảnh sản phẩm
-- ================================================

-- Điện thoại (product 1-30)
INSERT INTO product_images (product_id, image_url) VALUES
-- iPhone 15 Pro Max
(1, 'iphone-15-pro-max-1.jpg'),
(1, 'iphone-15-pro-max-2.jpg'),
(1, 'iphone-15-pro-max-3.jpg'),
(1, 'iphone-15-pro-max-4.jpg'),
(1, 'iphone-15-pro-max-5.jpg'),

-- iPhone 15 Pro
(2, 'iphone-15-pro-1.jpg'),
(2, 'iphone-15-pro-2.jpg'),
(2, 'iphone-15-pro-3.jpg'),
(2, 'iphone-15-pro-4.jpg'),

-- iPhone 15 Plus
(3, 'iphone-15-plus-1.jpg'),
(3, 'iphone-15-plus-2.jpg'),
(3, 'iphone-15-plus-3.jpg'),
(3, 'iphone-15-plus-4.jpg'),

-- iPhone 15
(4, 'iphone-15-1.jpg'),
(4, 'iphone-15-2.jpg'),
(4, 'iphone-15-3.jpg'),
(4, 'iphone-15-4.jpg'),
(4, 'iphone-15-5.jpg'),

-- iPhone 14 Pro Max
(5, 'iphone-14-pro-max-1.jpg'),
(5, 'iphone-14-pro-max-2.jpg'),
(5, 'iphone-14-pro-max-3.jpg'),

-- iPhone 14
(6, 'iphone-14-1.jpg'),
(6, 'iphone-14-2.jpg'),
(6, 'iphone-14-3.jpg'),

-- Samsung S24 Ultra
(7, 'samsung-s24-ultra-1.jpg'),
(7, 'samsung-s24-ultra-2.jpg'),
(7, 'samsung-s24-ultra-3.jpg'),
(7, 'samsung-s24-ultra-4.jpg'),
(7, 'samsung-s24-ultra-5.jpg'),

-- Samsung S24 Plus
(8, 'samsung-s24-plus-1.jpg'),
(8, 'samsung-s24-plus-2.jpg'),
(8, 'samsung-s24-plus-3.jpg'),

-- Samsung S24
(9, 'samsung-s24-1.jpg'),
(9, 'samsung-s24-2.jpg'),
(9, 'samsung-s24-3.jpg'),
(9, 'samsung-s24-4.jpg'),

-- Samsung S23 FE
(10, 'samsung-s23-fe-1.jpg'),
(10, 'samsung-s23-fe-2.jpg'),
(10, 'samsung-s23-fe-3.jpg'),

-- Samsung Z Fold5
(11, 'samsung-z-fold5-1.jpg'),
(11, 'samsung-z-fold5-2.jpg'),
(11, 'samsung-z-fold5-3.jpg'),
(11, 'samsung-z-fold5-4.jpg'),
(11, 'samsung-z-fold5-5.jpg'),

-- Samsung Z Flip5
(12, 'samsung-z-flip5-1.jpg'),
(12, 'samsung-z-flip5-2.jpg'),
(12, 'samsung-z-flip5-3.jpg'),
(12, 'samsung-z-flip5-4.jpg'),

-- Samsung A54
(13, 'samsung-a54-1.jpg'),
(13, 'samsung-a54-2.jpg'),
(13, 'samsung-a54-3.jpg'),

-- Samsung A34
(14, 'samsung-a34-1.jpg'),
(14, 'samsung-a34-2.jpg'),

-- Xiaomi 14 Ultra
(15, 'xiaomi-14-ultra-1.jpg'),
(15, 'xiaomi-14-ultra-2.jpg'),
(15, 'xiaomi-14-ultra-3.jpg'),
(15, 'xiaomi-14-ultra-4.jpg'),

-- Xiaomi 14
(16, 'xiaomi-14-1.jpg'),
(16, 'xiaomi-14-2.jpg'),
(16, 'xiaomi-14-3.jpg'),

-- Xiaomi 13T Pro
(17, 'xiaomi-13t-pro-1.jpg'),
(17, 'xiaomi-13t-pro-2.jpg'),
(17, 'xiaomi-13t-pro-3.jpg'),

-- Redmi Note 13 Pro
(18, 'redmi-note-13-pro-1.jpg'),
(18, 'redmi-note-13-pro-2.jpg'),
(18, 'redmi-note-13-pro-3.jpg'),

-- Redmi Note 13
(19, 'redmi-note-13-1.jpg'),
(19, 'redmi-note-13-2.jpg'),

-- OPPO Find N3
(20, 'oppo-find-n3-1.jpg'),
(20, 'oppo-find-n3-2.jpg'),
(20, 'oppo-find-n3-3.jpg'),
(20, 'oppo-find-n3-4.jpg'),

-- OPPO Reno11
(21, 'oppo-reno11-1.jpg'),
(21, 'oppo-reno11-2.jpg'),
(21, 'oppo-reno11-3.jpg'),

-- OPPO A78
(22, 'oppo-a78-1.jpg'),
(22, 'oppo-a78-2.jpg'),

-- Vivo V30 Pro
(23, 'vivo-v30-pro-1.jpg'),
(23, 'vivo-v30-pro-2.jpg'),
(23, 'vivo-v30-pro-3.jpg'),

-- Vivo V30
(24, 'vivo-v30-1.jpg'),
(24, 'vivo-v30-2.jpg'),

-- Vivo Y36
(25, 'vivo-y36-1.jpg'),
(25, 'vivo-y36-2.jpg'),

-- Realme 12 Pro+
(26, 'realme-12-pro-plus-1.jpg'),
(26, 'realme-12-pro-plus-2.jpg'),
(26, 'realme-12-pro-plus-3.jpg'),

-- Realme 11
(27, 'realme-11-1.jpg'),
(27, 'realme-11-2.jpg'),

-- Pixel 8 Pro
(28, 'pixel-8-pro-1.jpg'),
(28, 'pixel-8-pro-2.jpg'),
(28, 'pixel-8-pro-3.jpg'),
(28, 'pixel-8-pro-4.jpg'),

-- Pixel 8
(29, 'pixel-8-1.jpg'),
(29, 'pixel-8-2.jpg'),
(29, 'pixel-8-3.jpg'),

-- Nokia G42
(30, 'nokia-g42-1.jpg'),
(30, 'nokia-g42-2.jpg');

-- Laptop (product 31-70) - Chỉ làm mẫu cho một số sản phẩm chính
INSERT INTO product_images (product_id, image_url) VALUES
-- MacBook Pro 16 M3 Max
(31, 'macbook-pro-16-m3-max-1.jpg'),
(31, 'macbook-pro-16-m3-max-2.jpg'),
(31, 'macbook-pro-16-m3-max-3.jpg'),
(31, 'macbook-pro-16-m3-max-4.jpg'),

-- MacBook Pro 14 M3 Pro
(32, 'macbook-pro-14-m3-pro-1.jpg'),
(32, 'macbook-pro-14-m3-pro-2.jpg'),
(32, 'macbook-pro-14-m3-pro-3.jpg'),

-- MacBook Air 15 M3
(33, 'macbook-air-15-m3-1.jpg'),
(33, 'macbook-air-15-m3-2.jpg'),
(33, 'macbook-air-15-m3-3.jpg'),

-- MacBook Air 13 M3
(34, 'macbook-air-13-m3-1.jpg'),
(34, 'macbook-air-13-m3-2.jpg'),
(34, 'macbook-air-13-m3-3.jpg'),

-- MacBook Air 13 M2
(35, 'macbook-air-13-m2-1.jpg'),
(35, 'macbook-air-13-m2-2.jpg'),

-- Dell XPS 15
(36, 'dell-xps-15-1.jpg'),
(36, 'dell-xps-15-2.jpg'),
(36, 'dell-xps-15-3.jpg'),

-- Dell XPS 13 Plus
(37, 'dell-xps-13-plus-1.jpg'),
(37, 'dell-xps-13-plus-2.jpg'),

-- HP Spectre x360
(39, 'hp-spectre-x360-1.jpg'),
(39, 'hp-spectre-x360-2.jpg'),
(39, 'hp-spectre-x360-3.jpg'),

-- Lenovo ThinkPad X1 Carbon
(42, 'thinkpad-x1-carbon-1.jpg'),
(42, 'thinkpad-x1-carbon-2.jpg'),
(42, 'thinkpad-x1-carbon-3.jpg'),

-- ASUS ROG Zephyrus G14
(49, 'asus-rog-g14-1.jpg'),
(49, 'asus-rog-g14-2.jpg'),
(49, 'asus-rog-g14-3.jpg'),
(49, 'asus-rog-g14-4.jpg'),

-- ASUS ROG Strix G16
(50, 'asus-rog-strix-g16-1.jpg'),
(50, 'asus-rog-strix-g16-2.jpg'),
(50, 'asus-rog-strix-g16-3.jpg'),

-- MSI Raider GE78
(60, 'msi-raider-ge78-1.jpg'),
(60, 'msi-raider-ge78-2.jpg'),
(60, 'msi-raider-ge78-3.jpg'),
(60, 'msi-raider-ge78-4.jpg'),
(60, 'msi-raider-ge78-5.jpg'),

-- Razer Blade 15
(68, 'razer-blade-15-1.jpg'),
(68, 'razer-blade-15-2.jpg'),
(68, 'razer-blade-15-3.jpg'),

-- Alienware m18
(70, 'alienware-m18-1.jpg'),
(70, 'alienware-m18-2.jpg'),
(70, 'alienware-m18-3.jpg'),
(70, 'alienware-m18-4.jpg');

-- Tablet (product 71-90)
INSERT INTO product_images (product_id, image_url) VALUES
-- iPad Pro 12.9 M2
(71, 'ipad-pro-12.9-1.jpg'),
(71, 'ipad-pro-12.9-2.jpg'),
(71, 'ipad-pro-12.9-3.jpg'),

-- iPad Pro 11 M2
(72, 'ipad-pro-11-1.jpg'),
(72, 'ipad-pro-11-2.jpg'),
(72, 'ipad-pro-11-3.jpg'),

-- iPad Air 5
(73, 'ipad-air-5-1.jpg'),
(73, 'ipad-air-5-2.jpg'),

-- iPad Gen 10
(74, 'ipad-gen-10-1.jpg'),
(74, 'ipad-gen-10-2.jpg'),

-- iPad Gen 9
(75, 'ipad-gen-9-1.jpg'),
(75, 'ipad-gen-9-2.jpg'),

-- iPad mini 6
(76, 'ipad-mini-6-1.jpg'),
(76, 'ipad-mini-6-2.jpg'),

-- Galaxy Tab S9 Ultra
(77, 'tab-s9-ultra-1.jpg'),
(77, 'tab-s9-ultra-2.jpg'),
(77, 'tab-s9-ultra-3.jpg'),
(77, 'tab-s9-ultra-4.jpg'),

-- Galaxy Tab S9 Plus
(78, 'tab-s9-plus-1.jpg'),
(78, 'tab-s9-plus-2.jpg'),
(78, 'tab-s9-plus-3.jpg'),

-- Galaxy Tab S9
(79, 'tab-s9-1.jpg'),
(79, 'tab-s9-2.jpg'),
(79, 'tab-s9-3.jpg'),

-- Galaxy Tab S9 FE
(80, 'tab-s9-fe-1.jpg'),
(80, 'tab-s9-fe-2.jpg'),

-- Galaxy Tab A9 Plus
(81, 'tab-a9-plus-1.jpg'),
(81, 'tab-a9-plus-2.jpg'),

-- Xiaomi Pad 6 Max
(82, 'xiaomi-pad-6-max-1.jpg'),
(82, 'xiaomi-pad-6-max-2.jpg'),
(82, 'xiaomi-pad-6-max-3.jpg'),

-- Xiaomi Pad 6
(83, 'xiaomi-pad-6-1.jpg'),
(83, 'xiaomi-pad-6-2.jpg'),

-- Surface Go 3
(90, 'surface-go-3-1.jpg'),
(90, 'surface-go-3-2.jpg');

-- Smartwatch (product 91-110)
INSERT INTO product_images (product_id, image_url) VALUES
-- Apple Watch Ultra 2
(91, 'apple-watch-ultra-2-1.jpg'),
(91, 'apple-watch-ultra-2-2.jpg'),
(91, 'apple-watch-ultra-2-3.jpg'),
(91, 'apple-watch-ultra-2-4.jpg'),

-- Apple Watch Series 9
(92, 'apple-watch-series-9-1.jpg'),
(92, 'apple-watch-series-9-2.jpg'),
(92, 'apple-watch-series-9-3.jpg'),

-- Apple Watch SE
(93, 'apple-watch-se-1.jpg'),
(93, 'apple-watch-se-2.jpg'),

-- Galaxy Watch 6 Classic
(94, 'galaxy-watch-6-classic-1.jpg'),
(94, 'galaxy-watch-6-classic-2.jpg'),
(94, 'galaxy-watch-6-classic-3.jpg'),

-- Galaxy Watch 6
(95, 'galaxy-watch-6-1.jpg'),
(95, 'galaxy-watch-6-2.jpg'),

-- Garmin Fenix 7X
(103, 'garmin-fenix-7x-1.jpg'),
(103, 'garmin-fenix-7x-2.jpg'),
(103, 'garmin-fenix-7x-3.jpg');

-- Tai nghe (product 111-130)
INSERT INTO product_images (product_id, image_url) VALUES
-- AirPods Pro 2
(111, 'airpods-pro-2-1.jpg'),
(111, 'airpods-pro-2-2.jpg'),
(111, 'airpods-pro-2-3.jpg'),

-- AirPods 3
(112, 'airpods-3-1.jpg'),
(112, 'airpods-3-2.jpg'),

-- AirPods 2
(113, 'airpods-2-1.jpg'),
(113, 'airpods-2-2.jpg'),

-- AirPods Max
(114, 'airpods-max-1.jpg'),
(114, 'airpods-max-2.jpg'),
(114, 'airpods-max-3.jpg'),

-- Sony WH-1000XM5
(115, 'sony-wh-1000xm5-1.jpg'),
(115, 'sony-wh-1000xm5-2.jpg'),
(115, 'sony-wh-1000xm5-3.jpg'),

-- Sony WF-1000XM5
(116, 'sony-wf-1000xm5-1.jpg'),
(116, 'sony-wf-1000xm5-2.jpg'),

-- Galaxy Buds2 Pro
(118, 'galaxy-buds2-pro-1.jpg'),
(118, 'galaxy-buds2-pro-2.jpg'),

-- Bose QC Ultra
(120, 'bose-qc-ultra-1.jpg'),
(120, 'bose-qc-ultra-2.jpg'),
(120, 'bose-qc-ultra-3.jpg');

-- Phụ kiện (product 131-150)
INSERT INTO product_images (product_id, image_url) VALUES
-- Ốp lưng iPhone 15 Pro Max
(131, 'op-lung-iphone-15-pro-max-1.jpg'),
(131, 'op-lung-iphone-15-pro-max-2.jpg'),

-- Cường lực
(133, 'cuong-luc-iphone-15-1.jpg'),

-- Cáp Lightning
(134, 'cap-lightning-1.jpg'),
(134, 'cap-lightning-2.jpg'),

-- Củ sạc 20W
(136, 'cu-sac-20w-1.jpg'),
(136, 'cu-sac-20w-2.jpg'),

-- Củ sạc 67W GaN
(137, 'cu-sac-67w-1.jpg'),
(137, 'cu-sac-67w-2.jpg'),

-- Đế sạc MagSafe
(138, 'de-sac-magsafe-1.jpg'),
(138, 'de-sac-magsafe-2.jpg'),

-- Gimbal DJI OM 6
(141, 'dji-om6-1.jpg'),
(141, 'dji-om6-2.jpg'),
(141, 'dji-om6-3.jpg'),

-- Pin dự phòng Anker
(150, 'pin-anker-20000-1.jpg'),
(150, 'pin-anker-20000-2.jpg');

SET FOREIGN_KEY_CHECKS = 1;

-- ================================================
-- TỔNG KẾT PART 3
-- ================================================
-- Product Images: ~300 ảnh cho 150 sản phẩm
-- Trung bình mỗi sản phẩm có 2-5 ảnh
-- ================================================
