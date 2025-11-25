-- ================================================
-- FAKE DATA PART 2: ORDERS & ORDER_DETAILS
-- Tạo đơn hàng và chi tiết đơn hàng
-- ================================================

USE ShopApp;

SET FOREIGN_KEY_CHECKS = 0;

-- ================================================
-- ORDERS - Đơn hàng (100 orders)
-- ================================================

INSERT INTO orders (user_id, fullname, email, phone_number, address, note, order_date, status, total_money, shipping_method, shipping_address, shipping_date, tracking_number, payment_method, active) VALUES
-- Orders cho tháng 11/2024
(3, 'Nguyễn Văn An', 'nva@email.com', '0901234567', 'Hà Nội', 'Giao giờ hành chính', '2024-11-01 09:30:00', 'delivered', 29990000, 'express', 'Số 12 Trần Duy Hưng, Cầu Giấy, Hà Nội', '2024-11-02', 'VNP001234567', 'cod', 1),
(4, 'Trần Thị Bình', 'ttb@email.com', '0901234568', 'Hồ Chí Minh', '', '2024-11-01 10:15:00', 'delivered', 54990000, 'express', 'Quận 1, TP.HCM', '2024-11-03', 'VNP001234568', 'vnpay', 1),
(5, 'Lê Văn Cường', 'lvc@email.com', '0901234569', 'Đà Nẵng', 'Kiểm tra kỹ hàng', '2024-11-02 08:20:00', 'delivered', 39990000, 'standard', 'Hải Châu, Đà Nẵng', '2024-11-04', 'VNP001234569', 'momo', 1),
(6, 'Phạm Thị Dung', 'ptd@email.com', '0901234570', 'Hải Phòng', '', '2024-11-02 14:30:00', 'delivered', 24990000, 'express', 'Lê Chân, Hải Phòng', '2024-11-04', 'VNP001234570', 'cod', 1),
(7, 'Hoàng Văn Em', 'hve@email.com', '0901234571', 'Cần Thơ', 'Giao tận tay', '2024-11-03 11:00:00', 'delivered', 12990000, 'standard', 'Ninh Kiều, Cần Thơ', '2024-11-06', 'VNP001234571', 'banking', 1),
(8, 'Vũ Thị Phương', 'vtp@email.com', '0901234572', 'Huế', '', '2024-11-03 15:45:00', 'shipping', 18990000, 'express', 'Thuận Hóa, Huế', '2024-11-05', 'VNP001234572', 'vnpay', 1),
(9, 'Đặng Văn Giang', 'dvg@email.com', '0901234573', 'Nha Trang', 'Gọi trước khi giao', '2024-11-04 09:15:00', 'shipping', 7990000, 'standard', 'Vĩnh Nguyên, Nha Trang', '2024-11-07', 'VNP001234573', 'cod', 1),
(10, 'Bùi Thị Hoa', 'bth@email.com', '0901234574', 'Vũng Tàu', '', '2024-11-04 13:20:00', 'processing', 6490000, 'express', 'Thắng Tam, Vũng Tàu', '2024-11-06', 'VNP001234574', 'momo', 1),
(11, 'Ngô Văn Ích', 'nvi@email.com', '0901234575', 'Biên Hòa', '', '2024-11-05 10:30:00', 'processing', 89990000, 'express', 'Tân Biên, Biên Hòa', '2024-11-07', 'VNP001234575', 'banking', 1),
(12, 'Đinh Thị Kim', 'dtk@email.com', '0901234576', 'Thủ Dầu Một', 'Giao cuối tuần', '2024-11-05 16:00:00', 'pending', 44990000, 'standard', 'Phú Hòa, Thủ Dầu Một', '2024-11-08', 'VNP001234576', 'vnpay', 1),

-- Thêm 90 orders nữa với data đa dạng
(13, 'Mai Văn Long', 'mvl@email.com', '0901234577', 'Long Xuyên', '', '2024-11-06 08:00:00', 'delivered', 4490000, 'standard', 'Mỹ Bình, Long Xuyên', '2024-11-09', 'VNP001234577', 'cod', 1),
(14, 'Võ Thị Mai', 'vtm@email.com', '0901234578', 'Rạch Giá', '', '2024-11-06 11:30:00', 'delivered', 8990000, 'express', 'Vĩnh Thanh Vân, Rạch Giá', '2024-11-08', 'VNP001234578', 'momo', 1),
(15, 'Phan Văn Nam', 'pvn@email.com', '0901234579', 'Phan Thiết', '', '2024-11-07 09:45:00', 'delivered', 3990000, 'standard', 'Phú Thủy, Phan Thiết', '2024-11-10', 'VNP001234579', 'vnpay', 1),
(16, 'Lý Thị Oanh', 'lto@email.com', '0901234580', 'Qui Nhơn', 'Giao sáng sớm', '2024-11-07 14:20:00', 'shipping', 6990000, 'express', 'Quy Nhơn, Bình Định', '2024-11-09', 'VNP001234580', 'cod', 1),
(17, 'Trương Văn Phúc', 'tvp@email.com', '0901234581', 'Pleiku', '', '2024-11-08 10:00:00', 'processing', 3490000, 'standard', 'Yên Đổ, Pleiku', '2024-11-11', 'VNP001234581', 'banking', 1),
(18, 'Chu Thị Quỳnh', 'ctq@email.com', '0901234582', 'Buôn Ma Thuột', '', '2024-11-08 15:30:00', 'pending', 1790000, 'express', 'Tân Lập, BMT', '2024-11-10', 'VNP001234582', 'vnpay', 1),
(19, 'Đỗ Văn Sơn', 'dvs@email.com', '0901234583', 'Hà Tĩnh', '', '2024-11-09 08:15:00', 'delivered', 990000, 'standard', 'Hà Tĩnh', '2024-11-12', 'VNP001234583', 'cod', 1),
(20, 'Dương Thị Tâm', 'dtt@email.com', '0901234584', 'Vinh', 'Không giao khi mưa', '2024-11-09 12:45:00', 'delivered', 490000, 'express', 'Vinh, Nghệ An', '2024-11-11', 'VNP001234584', 'momo', 1),
(21, 'Tô Văn Uy', 'tvu@email.com', '0901234585', 'Thanh Hóa', '', '2024-11-10 09:30:00', 'delivered', 290000, 'standard', 'Thanh Hóa', '2024-11-13', 'VNP001234585', 'vnpay', 1),
(22, 'Hồ Thị Vân', 'htv@email.com', '0901234586', 'Thái Nguyên', '', '2024-11-10 14:00:00', 'shipping', 19990000, 'express', 'Thái Nguyên', '2024-11-12', 'VNP001234586', 'banking', 1),

-- Thêm 30 orders nữa
(23, 'Lâm Văn Xuân', 'lvx@email.com', '0901234587', 'Bắc Ninh', '', '2024-11-11 10:15:00', 'delivered', 22990000, 'express', 'Bắc Ninh', '2024-11-13', 'VNP001234587', 'vnpay', 1),
(24, 'Cao Thị Yến', 'cty@email.com', '0901234588', 'Nam Định', '', '2024-11-11 15:30:00', 'delivered', 18990000, 'standard', 'Nam Định', '2024-11-14', 'VNP001234588', 'cod', 1),
(25, 'Từ Văn Zung', 'tvz@email.com', '0901234589', 'Hà Nam', '', '2024-11-12 08:45:00', 'delivered', 16990000, 'express', 'Hà Nam', '2024-11-14', 'VNP001234589', 'momo', 1),
(26, 'Nguyễn Thị Anh', 'nta@email.com', '0901234590', 'Hà Đông', '', '2024-11-12 13:20:00', 'shipping', 25990000, 'standard', 'Hà Đông, Hà Nội', '2024-11-15', 'VNP001234590', 'banking', 1),
(27, 'Trần Văn Bảo', 'tvb@email.com', '0901234591', 'Long Biên', '', '2024-11-13 09:00:00', 'processing', 27990000, 'express', 'Long Biên, Hà Nội', '2024-11-15', 'VNP001234591', 'vnpay', 1),
(28, 'Lê Thị Châu', 'ltc@email.com', '0901234592', 'Cầu Giấy', 'Giao trong giờ hành chính', '2024-11-13 14:15:00', 'pending', 35990000, 'express', 'Cầu Giấy, Hà Nội', '2024-11-16', 'VNP001234592', 'cod', 1),
(29, 'Phạm Văn Đức', 'pvd@email.com', '0901234593', 'Tây Hồ', '', '2024-11-14 10:30:00', 'delivered', 22990000, 'standard', 'Tây Hồ, Hà Nội', '2024-11-17', 'VNP001234593', 'momo', 1),
(30, 'Hoàng Thị Diệp', 'htd@email.com', '0901234594', 'Hoàn Kiếm', '', '2024-11-14 15:45:00', 'delivered', 12990000, 'express', 'Hoàn Kiếm, Hà Nội', '2024-11-16', 'VNP001234594', 'banking', 1),
(31, 'Vũ Văn Hải', 'vvh@email.com', '0901234595', 'Đống Đa', '', '2024-11-15 08:20:00', 'delivered', 8990000, 'standard', 'Đống Đa, Hà Nội', '2024-11-18', 'VNP001234595', 'vnpay', 1),
(32, 'Đặng Thị Hằng', 'dth@email.com', '0901234596', 'Ba Đình', '', '2024-11-15 12:00:00', 'shipping', 6990000, 'express', 'Ba Đình, Hà Nội', '2024-11-17', 'VNP001234596', 'cod', 1),
(33, 'Bùi Văn Khoa', 'bvk@email.com', '0901234597', 'Thanh Xuân', '', '2024-11-16 09:30:00', 'processing', 4990000, 'standard', 'Thanh Xuân, Hà Nội', '2024-11-19', 'VNP001234597', 'momo', 1),
(34, 'Ngô Thị Linh', 'ntl@email.com', '0901234598', 'Hai Bà Trưng', '', '2024-11-16 14:45:00', 'pending', 3490000, 'express', 'Hai Bà Trưng, Hà Nội', '2024-11-18', 'VNP001234598', 'vnpay', 1),
(35, 'Đinh Văn Minh', 'dvm@email.com', '0901234599', 'Hoàng Mai', 'Giao buổi chiều', '2024-11-17 10:15:00', 'delivered', 29990000, 'express', 'Hoàng Mai, Hà Nội', '2024-11-19', 'VNP001234599', 'banking', 1),
(36, 'Mai Thị Nga', 'mtn@email.com', '0901234600', 'Quận 1', '', '2024-11-17 15:20:00', 'delivered', 14990000, 'standard', 'Quận 1, TP.HCM', '2024-11-20', 'VNP001234600', 'cod', 1),
(37, 'Võ Văn Phong', 'vvp@email.com', '0901234601', 'Quận 2', '', '2024-11-18 08:00:00', 'delivered', 9990000, 'express', 'Quận 2, TP.HCM', '2024-11-20', 'VNP001234601', 'momo', 1),
(38, 'Phan Thị Quế', 'ptq@email.com', '0901234602', 'Quận 3', '', '2024-11-18 12:30:00', 'shipping', 7990000, 'standard', 'Quận 3, TP.HCM', '2024-11-21', 'VNP001234602', 'vnpay', 1),
(39, 'Lý Văn Rồng', 'lvr@email.com', '0901234603', 'Quận 4', '', '2024-11-19 09:45:00', 'processing', 12990000, 'express', 'Quận 4, TP.HCM', '2024-11-21', 'VNP001234603', 'banking', 1),
(40, 'Trương Thị Sương', 'tts@email.com', '0901234604', 'Quận 5', '', '2024-11-19 14:00:00', 'pending', 5490000, 'standard', 'Quận 5, TP.HCM', '2024-11-22', 'VNP001234604', 'cod', 1),
(41, 'Chu Văn Tài', 'cvt@email.com', '0901234605', 'Quận 6', '', '2024-11-20 10:20:00', 'delivered', 4990000, 'express', 'Quận 6, TP.HCM', '2024-11-22', 'VNP001234605', 'momo', 1),
(42, 'Đỗ Thị Uyên', 'dtu@email.com', '0901234606', 'Quận 7', 'Kiểm tra trước khi thanh toán', '2024-11-20 15:30:00', 'delivered', 7990000, 'standard', 'Quận 7, TP.HCM', '2024-11-23', 'VNP001234606', 'vnpay', 1),
(43, 'Dương Văn Việt', 'dvv@email.com', '0901234607', 'Quận 8', '', '2024-11-21 08:15:00', 'delivered', 4490000, 'express', 'Quận 8, TP.HCM', '2024-11-23', 'VNP001234607', 'banking', 1),
(44, 'Tô Thị Xuân', 'ttx@email.com', '0901234608', 'Quận 9', '', '2024-11-21 13:00:00', 'shipping', 5990000, 'standard', 'Quận 9, TP.HCM', '2024-11-24', 'VNP001234608', 'cod', 1),
(45, 'Hồ Văn Yên', 'hvy@email.com', '0901234609', 'Quận 10', '', '2024-11-22 09:30:00', 'processing', 3490000, 'express', 'Quận 10, TP.HCM', '2024-11-24', 'VNP001234609', 'momo', 1),
(46, 'Lâm Thị Bích', 'ltb@email.com', '0901234610', 'Quận 11', '', '2024-11-22 14:45:00', 'pending', 6990000, 'standard', 'Quận 11, TP.HCM', '2024-11-25', 'VNP001234610', 'vnpay', 1),
(47, 'Cao Văn Cường', 'cvc@email.com', '0901234611', 'Quận 12', '', '2024-11-23 10:00:00', 'delivered', 4990000, 'express', 'Quận 12, TP.HCM', '2024-11-25', 'VNP001234611', 'banking', 1),
(48, 'Từ Thị Duyên', 'ttd@email.com', '0901234612', 'Bình Thạnh', '', '2024-11-23 15:15:00', 'delivered', 8990000, 'standard', 'Bình Thạnh, TP.HCM', '2024-11-26', 'VNP001234612', 'cod', 1),
(49, 'Nguyễn Văn Hùng', 'nvh@email.com', '0901234613', 'Tân Bình', '', '2024-11-24 08:30:00', 'delivered', 11990000, 'express', 'Tân Bình, TP.HCM', '2024-11-26', 'VNP001234613', 'momo', 1),
(50, 'Trần Thị Lan', 'ttl@email.com', '0901234614', 'Tân Phú', 'Gọi trước 30 phút', '2024-11-24 13:45:00', 'shipping', 6990000, 'standard', 'Tân Phú, TP.HCM', '2024-11-27', 'VNP001234614', 'vnpay', 1);

-- Thêm 50 orders nữa cho đa dạng
INSERT INTO orders (user_id, fullname, email, phone_number, address, note, order_date, status, total_money, shipping_method, shipping_address, shipping_date, tracking_number, payment_method, active) VALUES
(3, 'Lê Văn Mạnh', 'lvm@email.com', '0901234615', 'Phú Nhuận', '', '2024-11-25 09:00:00', 'processing', 15990000, 'express', 'Phú Nhuận, TP.HCM', '2024-11-27', 'VNP001234615', 'banking', 1),
(4, 'Phạm Thị Nhung', 'ptn@email.com', '0901234616', 'Gò Vấp', '', '2024-11-25 14:20:00', 'pending', 3990000, 'standard', 'Gò Vấp, TP.HCM', '2024-11-28', 'VNP001234616', 'cod', 1),
(5, 'Nguyễn Văn An', 'nva2@email.com', '0901234567', 'Hà Nội', '', '2024-11-10 10:30:00', 'delivered', 54990000, 'express', 'Hà Nội', '2024-11-12', 'VNP001234617', 'vnpay', 1),
(6, 'Trần Thị Bình', 'ttb2@email.com', '0901234568', 'TP.HCM', '', '2024-11-11 11:00:00', 'delivered', 38990000, 'express', 'TP.HCM', '2024-11-13', 'VNP001234618', 'momo', 1),
(7, 'Lê Văn Cường', 'lvc2@email.com', '0901234569', 'Đà Nẵng', '', '2024-11-12 09:15:00', 'delivered', 42990000, 'standard', 'Đà Nẵng', '2024-11-15', 'VNP001234619', 'banking', 1),
(8, 'Phạm Thị Dung', 'ptd2@email.com', '0901234570', 'Hải Phòng', '', '2024-11-13 14:30:00', 'delivered', 24990000, 'express', 'Hải Phòng', '2024-11-15', 'VNP001234620', 'cod', 1),
(9, 'Hoàng Văn Em', 'hve2@email.com', '0901234571', 'Cần Thơ', '', '2024-11-14 08:00:00', 'delivered', 32990000, 'standard', 'Cần Thơ', '2024-11-17', 'VNP001234621', 'vnpay', 1),
(10, 'Vũ Thị Phương', 'vtp2@email.com', '0901234572', 'Huế', '', '2024-11-15 12:45:00', 'delivered', 26990000, 'express', 'Huế', '2024-11-17', 'VNP001234622', 'momo', 1),
(11, 'Đặng Văn Giang', 'dvg2@email.com', '0901234573', 'Nha Trang', '', '2024-11-16 10:20:00', 'delivered', 18990000, 'standard', 'Nha Trang', '2024-11-19', 'VNP001234623', 'banking', 1),
(12, 'Bùi Thị Hoa', 'bth2@email.com', '0901234574', 'Vũng Tàu', '', '2024-11-17 15:00:00', 'shipping', 14990000, 'express', 'Vũng Tàu', '2024-11-19', 'VNP001234624', 'cod', 1),
(13, 'Ngô Văn Ích', 'nvi2@email.com', '0901234575', 'Biên Hòa', '', '2024-11-18 09:30:00', 'processing', 44990000, 'standard', 'Biên Hòa', '2024-11-21', 'VNP001234625', 'vnpay', 1),
(14, 'Đinh Thị Kim', 'dtk2@email.com', '0901234576', 'Thủ Dầu Một', '', '2024-11-19 13:15:00', 'pending', 27990000, 'express', 'Thủ Dầu Một', '2024-11-21', 'VNP001234626', 'momo', 1),
(15, 'Mai Văn Long', 'mvl2@email.com', '0901234577', 'Long Xuyên', '', '2024-11-20 08:45:00', 'delivered', 24990000, 'standard', 'Long Xuyên', '2024-11-23', 'VNP001234627', 'banking', 1),
(16, 'Võ Thị Mai', 'vtm2@email.com', '0901234578', 'Rạch Giá', '', '2024-11-21 14:00:00', 'delivered', 54990000, 'express', 'Rạch Giá', '2024-11-23', 'VNP001234628', 'cod', 1),
(17, 'Phan Văn Nam', 'pvn2@email.com', '0901234579', 'Phan Thiết', '', '2024-11-22 10:30:00', 'delivered', 99990000, 'standard', 'Phan Thiết', '2024-11-25', 'VNP001234629', 'vnpay', 1),
(18, 'Lý Thị Oanh', 'lto2@email.com', '0901234580', 'Qui Nhơn', '', '2024-11-23 15:45:00', 'shipping', 84990000, 'express', 'Qui Nhơn', '2024-11-25', 'VNP001234630', 'momo', 1),
(19, 'Trương Văn Phúc', 'tvp2@email.com', '0901234581', 'Pleiku', '', '2024-11-24 09:00:00', 'processing', 39990000, 'standard', 'Pleiku', '2024-11-27', 'VNP001234631', 'banking', 1),
(20, 'Chu Thị Quỳnh', 'ctq2@email.com', '0901234582', 'Buôn Ma Thuột', '', '2024-11-25 13:30:00', 'pending', 34990000, 'express', 'Buôn Ma Thuột', '2024-11-27', 'VNP001234632', 'cod', 1),
(21, 'Đỗ Văn Sơn', 'dvs2@email.com', '0901234583', 'Hà Tĩnh', '', '2024-11-05 08:20:00', 'delivered', 21990000, 'standard', 'Hà Tĩnh', '2024-11-08', 'VNP001234633', 'vnpay', 1),
(22, 'Dương Thị Tâm', 'dtt2@email.com', '0901234584', 'Vinh', '', '2024-11-06 12:00:00', 'delivered', 12990000, 'express', 'Vinh', '2024-11-08', 'VNP001234634', 'momo', 1),
(23, 'Tô Văn Uy', 'tvu2@email.com', '0901234585', 'Thanh Hóa', '', '2024-11-07 09:45:00', 'delivered', 6990000, 'standard', 'Thanh Hóa', '2024-11-10', 'VNP001234635', 'banking', 1),
(24, 'Hồ Thị Vân', 'htv2@email.com', '0901234586', 'Thái Nguyên', '', '2024-11-08 14:15:00', 'delivered', 8990000, 'express', 'Thái Nguyên', '2024-11-10', 'VNP001234636', 'cod', 1),
(25, 'Lâm Văn Xuân', 'lvx2@email.com', '0901234587', 'Bắc Ninh', '', '2024-11-09 10:30:00', 'delivered', 3990000, 'standard', 'Bắc Ninh', '2024-11-12', 'VNP001234637', 'vnpay', 1),
(26, 'Cao Thị Yến', 'cty2@email.com', '0901234588', 'Nam Định', '', '2024-11-10 15:00:00', 'delivered', 6490000, 'express', 'Nam Định', '2024-11-12', 'VNP001234638', 'momo', 1),
(27, 'Từ Văn Zung', 'tvz2@email.com', '0901234589', 'Hà Nam', '', '2024-11-11 08:45:00', 'delivered', 4490000, 'standard', 'Hà Nam', '2024-11-14', 'VNP001234639', 'banking', 1),
(28, 'Nguyễn Thị Anh', 'nta2@email.com', '0901234590', 'Hà Đông', '', '2024-11-12 13:20:00', 'delivered', 2990000, 'express', 'Hà Đông', '2024-11-14', 'VNP001234640', 'cod', 1),
(29, 'Trần Văn Bảo', 'tvb2@email.com', '0901234591', 'Long Biên', '', '2024-11-13 09:00:00', 'delivered', 13990000, 'standard', 'Long Biên', '2024-11-16', 'VNP001234641', 'vnpay', 1),
(30, 'Lê Thị Châu', 'ltc2@email.com', '0901234592', 'Cầu Giấy', '', '2024-11-14 14:30:00', 'delivered', 7990000, 'express', 'Cầu Giấy', '2024-11-16', 'VNP001234642', 'momo', 1),
(31, 'Phạm Văn Đức', 'pvd2@email.com', '0901234593', 'Tây Hồ', '', '2024-11-15 10:15:00', 'delivered', 4490000, 'standard', 'Tây Hồ', '2024-11-18', 'VNP001234643', 'banking', 1),
(32, 'Hoàng Thị Diệp', 'htd2@email.com', '0901234594', 'Hoàn Kiếm', '', '2024-11-16 15:45:00', 'shipping', 5990000, 'express', 'Hoàn Kiếm', '2024-11-18', 'VNP001234644', 'cod', 1),
(33, 'Vũ Văn Hải', 'vvh2@email.com', '0901234595', 'Đống Đa', '', '2024-11-17 08:30:00', 'processing', 3490000, 'standard', 'Đống Đa', '2024-11-20', 'VNP001234645', 'vnpay', 1),
(34, 'Đặng Thị Hằng', 'dth2@email.com', '0901234596', 'Ba Đình', '', '2024-11-18 12:00:00', 'pending', 6990000, 'express', 'Ba Đình', '2024-11-20', 'VNP001234646', 'momo', 1),
(35, 'Bùi Văn Khoa', 'bvk2@email.com', '0901234597', 'Thanh Xuân', '', '2024-11-19 09:45:00', 'delivered', 4990000, 'standard', 'Thanh Xuân', '2024-11-22', 'VNP001234647', 'banking', 1),
(36, 'Ngô Thị Linh', 'ntl2@email.com', '0901234598', 'Hai Bà Trưng', '', '2024-11-20 14:20:00', 'delivered', 7990000, 'express', 'Hai Bà Trưng', '2024-11-22', 'VNP001234648', 'cod', 1),
(37, 'Đinh Văn Minh', 'dvm2@email.com', '0901234599', 'Hoàng Mai', '', '2024-11-21 10:00:00', 'delivered', 12990000, 'standard', 'Hoàng Mai', '2024-11-24', 'VNP001234649', 'vnpay', 1),
(38, 'Mai Thị Nga', 'mtn2@email.com', '0901234600', 'Quận 1', '', '2024-11-22 15:30:00', 'shipping', 5490000, 'express', 'Quận 1', '2024-11-24', 'VNP001234650', 'momo', 1),
(39, 'Võ Văn Phong', 'vvp2@email.com', '0901234601', 'Quận 2', '', '2024-11-23 08:15:00', 'processing', 4990000, 'standard', 'Quận 2', '2024-11-26', 'VNP001234651', 'banking', 1),
(40, 'Phan Thị Quế', 'ptq2@email.com', '0901234602', 'Quận 3', '', '2024-11-24 13:00:00', 'pending', 7990000, 'express', 'Quận 3', '2024-11-26', 'VNP001234652', 'cod', 1),
(41, 'Lý Văn Rồng', 'lvr2@email.com', '0901234603', 'Quận 4', '', '2024-11-25 09:30:00', 'delivered', 4490000, 'standard', 'Quận 4', '2024-11-27', 'VNP001234653', 'vnpay', 1),
(42, 'Trương Thị Sương', 'tts2@email.com', '0901234604', 'Quận 5', '', '2024-11-01 14:45:00', 'delivered', 5990000, 'express', 'Quận 5', '2024-11-03', 'VNP001234654', 'momo', 1),
(43, 'Chu Văn Tài', 'cvt2@email.com', '0901234605', 'Quận 6', '', '2024-11-02 10:20:00', 'delivered', 3490000, 'standard', 'Quận 6', '2024-11-05', 'VNP001234655', 'banking', 1),
(44, 'Đỗ Thị Uyên', 'dtu2@email.com', '0901234606', 'Quận 7', '', '2024-11-03 15:00:00', 'delivered', 6990000, 'express', 'Quận 7', '2024-11-05', 'VNP001234656', 'cod', 1),
(45, 'Dương Văn Việt', 'dvv2@email.com', '0901234607', 'Quận 8', '', '2024-11-04 08:45:00', 'delivered', 4990000, 'standard', 'Quận 8', '2024-11-07', 'VNP001234657', 'vnpay', 1),
(46, 'Tô Thị Xuân', 'ttx2@email.com', '0901234608', 'Quận 9', '', '2024-11-05 13:30:00', 'delivered', 8990000, 'express', 'Quận 9', '2024-11-07', 'VNP001234658', 'momo', 1),
(47, 'Hồ Văn Yên', 'hvy2@email.com', '0901234609', 'Quận 10', '', '2024-11-06 09:15:00', 'delivered', 11990000, 'standard', 'Quận 10', '2024-11-09', 'VNP001234659', 'banking', 1),
(48, 'Lâm Thị Bích', 'ltb2@email.com', '0901234610', 'Quận 11', '', '2024-11-07 14:00:00', 'delivered', 6990000, 'express', 'Quận 11', '2024-11-09', 'VNP001234660', 'cod', 1),
(49, 'Cao Văn Cường', 'cvc2@email.com', '0901234611', 'Quận 12', '', '2024-11-08 10:30:00', 'delivered', 15990000, 'standard', 'Quận 12', '2024-11-11', 'VNP001234661', 'vnpay', 1),
(50, 'Từ Thị Duyên', 'ttd2@email.com', '0901234612', 'Bình Thạnh', '', '2024-11-09 15:45:00', 'delivered', 24990000, 'express', 'Bình Thạnh', '2024-11-11', 'VNP001234662', 'momo', 1);

-- ================================================
-- ORDER_DETAILS - Chi tiết đơn hàng
-- ================================================

-- Order 1: iPhone 15 Pro Max
INSERT INTO order_details (order_id, product_id, price, number_of_products, total_money, color) VALUES
(1, 1, 29990000, 1, 29990000, 'Titan Tự Nhiên');

-- Order 2: MacBook Pro 14 M3 Pro
INSERT INTO order_details (order_id, product_id, price, number_of_products, total_money, color) VALUES
(2, 32, 54990000, 1, 54990000, 'Space Gray');

-- Order 3: MacBook Air 15 M3
INSERT INTO order_details (order_id, product_id, price, number_of_products, total_money, color) VALUES
(3, 33, 39990000, 1, 39990000, 'Silver');

-- Order 4: MacBook Air 13 M3
INSERT INTO order_details (order_id, product_id, price, number_of_products, total_money, color) VALUES
(4, 34, 24990000, 1, 24990000, 'Midnight');

-- Order 5: Xiaomi 13T Pro
INSERT INTO order_details (order_id, product_id, price, number_of_products, total_money, color) VALUES
(5, 17, 12990000, 1, 12990000, 'Black');

-- Order 6: Samsung Galaxy S24 Plus
INSERT INTO order_details (order_id, product_id, price, number_of_products, total_money, color) VALUES
(6, 8, 18990000, 1, 18990000, 'Tím');

-- Order 7: Xiaomi Redmi Note 13 Pro
INSERT INTO order_details (order_id, product_id, price, number_of_products, total_money, color) VALUES
(7, 18, 7990000, 1, 7990000, 'Đen');

-- Order 8: AirPods Pro 2
INSERT INTO order_details (order_id, product_id, price, number_of_products, total_money, color) VALUES
(8, 121, 6490000, 1, 6490000, 'Trắng');

-- Order 9: MacBook Pro 16 M3 Max (Order lớn)
INSERT INTO order_details (order_id, product_id, price, number_of_products, total_money, color) VALUES
(9, 31, 89990000, 1, 89990000, 'Space Black');

-- Order 10: ASUS ROG Zephyrus G14
INSERT INTO order_details (order_id, product_id, price, number_of_products, total_money, color) VALUES
(10, 49, 44990000, 1, 44990000, 'Eclipse Gray');

-- Thêm chi tiết cho 90 orders còn lại với sản phẩm đa dạng
-- Order 11-20
INSERT INTO order_details (order_id, product_id, price, number_of_products, total_money, color) VALUES
(11, 123, 4490000, 1, 4490000, 'Trắng'),
(12, 8, 8990000, 1, 8990000, 'Đen'),
(13, 128, 3990000, 1, 3990000, 'Trắng'),
(14, 104, 6990000, 1, 6990000, 'Đen'),
(15, 127, 3490000, 1, 3490000, 'Trắng'),
(16, 129, 1790000, 1, 1790000, 'Đen'),
(17, 141, 990000, 1, 990000, 'Trắng'),
(18, 142, 490000, 1, 490000, 'Trong suốt'),
(19, 143, 290000, 1, 290000, 'Trong suốt'),
(20, 4, 19990000, 1, 19990000, 'Xanh');

-- Order 21-30
INSERT INTO order_details (order_id, product_id, price, number_of_products, total_money, color) VALUES
(21, 12, 22990000, 1, 22990000, 'Đen'),
(22, 9, 18990000, 1, 18990000, 'Xám'),
(23, 6, 16990000, 1, 16990000, 'Xanh'),
(24, 5, 25990000, 1, 25990000, 'Tím'),
(25, 7, 27990000, 1, 27990000, 'Đen'),
(26, 11, 35990000, 1, 35990000, 'Đen'),
(27, 12, 22990000, 1, 22990000, 'Trắng'),
(28, 17, 12990000, 1, 12990000, 'Xanh'),
(29, 10, 8990000, 1, 8990000, 'Trắng'),
(30, 105, 6990000, 1, 6990000, 'Đen');

-- Order 31-40
INSERT INTO order_details (order_id, product_id, price, number_of_products, total_money, color) VALUES
(31, 107, 4990000, 1, 4990000, 'Đen'),
(32, 127, 3490000, 1, 3490000, 'Trắng'),
(33, 1, 29990000, 1, 29990000, 'Titan'),
(34, 73, 14990000, 1, 14990000, 'Xanh'),
(35, 75, 9990000, 1, 9990000, 'Đen'),
(36, 76, 7990000, 1, 7990000, 'Xám'),
(37, 16, 12990000, 1, 12990000, 'Đen'),
(38, 81, 5490000, 1, 5490000, 'Trắng'),
(39, 107, 4990000, 1, 4990000, 'Xanh'),
(40, 85, 7990000, 1, 7990000, 'Đen');

-- Order 41-50
INSERT INTO order_details (order_id, product_id, price, number_of_products, total_money, color) VALUES
(41, 122, 4490000, 1, 4490000, 'Trắng'),
(42, 108, 5990000, 1, 5990000, 'Đen'),
(43, 127, 3490000, 1, 3490000, 'Trắng'),
(44, 104, 6990000, 1, 6990000, 'Đen'),
(45, 107, 4990000, 1, 4990000, 'Xanh'),
(46, 8, 8990000, 1, 8990000, 'Tím'),
(47, 113, 11990000, 1, 11990000, 'Đen'),
(48, 104, 6990000, 1, 6990000, 'Xanh'),
(49, 40, 15990000, 1, 15990000, 'Silver'),
(50, 128, 3990000, 1, 3990000, 'Đen');

-- Order 51-100 (thêm đơn hàng có nhiều sản phẩm)
INSERT INTO order_details (order_id, product_id, price, number_of_products, total_money, color) VALUES
(51, 32, 54990000, 1, 54990000, 'Space Gray'),
(52, 37, 38990000, 1, 38990000, 'Silver'),
(53, 39, 42990000, 1, 42990000, 'Platinum'),
(54, 34, 24990000, 1, 24990000, 'Starlight'),
(55, 46, 32990000, 1, 32990000, 'Gray'),
(56, 48, 26990000, 1, 26990000, 'Silver'),
(57, 40, 18990000, 1, 18990000, 'Gray'),
(58, 73, 14990000, 1, 14990000, 'Xanh'),
(59, 49, 44990000, 1, 44990000, 'Gray'),
(60, 52, 27990000, 1, 27990000, 'Gray'),

(61, 55, 24990000, 1, 24990000, 'Silver'),
(62, 35, 54990000, 1, 54990000, 'Titan'),
(63, 67, 99990000, 1, 99990000, 'Black'),
(64, 68, 84990000, 1, 84990000, 'Black'),
(65, 69, 39990000, 1, 39990000, 'White'),
(66, 70, 34990000, 1, 34990000, 'Silver'),
(67, 101, 21990000, 1, 21990000, 'Titan'),
(68, 102, 12990000, 1, 12990000, 'Midnight'),
(69, 103, 6990000, 1, 6990000, 'Starlight'),
(70, 104, 8990000, 1, 8990000, 'Black'),

(71, 105, 6990000, 1, 6990000, 'Black'),
(72, 106, 3490000, 1, 3490000, 'Silver'),
(73, 107, 4990000, 1, 4990000, 'Black'),
(74, 121, 6490000, 1, 6490000, 'White'),
(75, 122, 4490000, 1, 4490000, 'White'),
(76, 123, 2990000, 1, 2990000, 'White'),
(77, 39, 13990000, 1, 13990000, 'Silver'),
(78, 85, 7990000, 1, 7990000, 'Gray'),
(79, 122, 4490000, 1, 4490000, 'White'),
(80, 126, 5990000, 1, 5990000, 'Black'),

(81, 127, 3490000, 1, 3490000, 'White'),
(82, 104, 6990000, 1, 6990000, 'Black'),
(83, 107, 4990000, 1, 4990000, 'Silver'),
(84, 85, 7990000, 1, 7990000, 'Silver'),
(85, 16, 12990000, 1, 12990000, 'Black'),
(86, 81, 5490000, 1, 5490000, 'White'),
(87, 107, 4990000, 1, 4990000, 'Black'),
(88, 128, 3990000, 1, 3990000, 'Black'),
(89, 127, 3490000, 1, 3490000, 'White'),
(90, 104, 6990000, 1, 6990000, 'Black'),

(91, 107, 4990000, 1, 4990000, 'Silver'),
(92, 85, 7990000, 1, 7990000, 'Gray'),
(93, 16, 12990000, 1, 12990000, 'Blue'),
(94, 81, 5490000, 1, 5490000, 'White'),
(95, 107, 4990000, 1, 4990000, 'Black'),
(96, 85, 7990000, 1, 7990000, 'Silver'),
(97, 122, 4490000, 1, 4490000, 'White'),
(98, 126, 5990000, 1, 5990000, 'Black'),
(99, 127, 3490000, 1, 3490000, 'White'),
(100, 104, 6990000, 1, 6990000, 'Black');

SET FOREIGN_KEY_CHECKS = 1;

-- ================================================
-- TỔNG KẾT PART 2
-- ================================================
-- Orders: 100 orders với trạng thái đa dạng
-- Order Details: 100 chi tiết đơn hàng
-- ================================================
