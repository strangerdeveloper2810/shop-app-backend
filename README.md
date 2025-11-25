# ShopApp Backend - E-Commerce Platform

## 📖 Giới thiệu

ShopApp Backend là một hệ thống backend RESTful API cho ứng dụng thương mại điện tử, được xây dựng bằng Spring Boot 3.3.3. Dự án cung cấp đầy đủ các tính năng quản lý sản phẩm, đơn hàng, người dùng và phân quyền.

## 🚀 Công nghệ sử dụng

### Backend Framework & Libraries
- **Spring Boot 3.3.3** - Framework chính
- **Spring Security** - Bảo mật và xác thực
- **Spring Data JPA** - ORM và database access
- **Hibernate** - JPA implementation
- **MySQL 8.0** - Database
- **JWT (JSON Web Token)** - Authentication & Authorization
- **BCrypt** - Mã hóa mật khẩu
- **ModelMapper** - Object mapping
- **Lombok** - Giảm boilerplate code
- **Validation API** - Validation dữ liệu

### DevOps & Tools
- **Docker & Docker Compose** - Containerization
- **Maven** - Build tool
- **Java 17** - Programming language

## 📁 Cấu trúc dự án

```
spring-backend/
├── src/
│   ├── main/
│   │   ├── java/com/project/shopapp/
│   │   │   ├── components/          # Các component tiện ích
│   │   │   │   ├── JwtTokenUtil.java         # Xử lý JWT token
│   │   │   │   └── LocalizationUtils.java    # Đa ngôn ngữ
│   │   │   │
│   │   │   ├── configurations/      # Cấu hình ứng dụng
│   │   │   │   ├── LanguageConfig.java       # Cấu hình i18n
│   │   │   │   ├── MapperConfiguration.java  # Config ModelMapper & Jackson
│   │   │   │   ├── SecurityConfig.java       # Config bảo mật cơ bản
│   │   │   │   ├── WebMvcConfig.java         # Config HTTP & UTF-8
│   │   │   │   └── WebSecurityConfig.java    # Config Spring Security
│   │   │   │
│   │   │   ├── controllers/         # REST API Controllers
│   │   │   │   ├── CategoryController.java   # API danh mục
│   │   │   │   ├── OrderController.java      # API đơn hàng
│   │   │   │   ├── OrderDetailController.java # API chi tiết đơn hàng
│   │   │   │   ├── ProductController.java    # API sản phẩm
│   │   │   │   ├── RoleController.java       # API vai trò
│   │   │   │   └── UserController.java       # API người dùng
│   │   │   │
│   │   │   ├── dtos/                # Data Transfer Objects
│   │   │   │   ├── CategoryDTO.java
│   │   │   │   ├── OrderDTO.java
│   │   │   │   ├── OrderDetailDTO.java
│   │   │   │   ├── ProductDTO.java
│   │   │   │   ├── ProductImageDTO.java
│   │   │   │   ├── UserDTO.java
│   │   │   │   └── UserLoginDTO.java
│   │   │   │
│   │   │   ├── exceptions/          # Custom exceptions
│   │   │   │   ├── DataNotFoundException.java
│   │   │   │   └── InvalidParamException.java
│   │   │   │
│   │   │   ├── filters/             # Security filters
│   │   │   │   └── JwtTokenFilter.java       # Filter xác thực JWT
│   │   │   │
│   │   │   ├── models/              # Entity models (JPA)
│   │   │   │   ├── BaseEntity.java           # Base entity với timestamps
│   │   │   │   ├── Category.java             # Danh mục sản phẩm
│   │   │   │   ├── Order.java                # Đơn hàng
│   │   │   │   ├── OrderDetail.java          # Chi tiết đơn hàng
│   │   │   │   ├── OrderStatus.java          # Enum trạng thái đơn hàng
│   │   │   │   ├── Product.java              # Sản phẩm
│   │   │   │   ├── ProductImage.java         # Hình ảnh sản phẩm
│   │   │   │   ├── Role.java                 # Vai trò người dùng
│   │   │   │   ├── SocialAccount.java        # Tài khoản mạng xã hội
│   │   │   │   ├── Token.java                # JWT tokens
│   │   │   │   └── User.java                 # Người dùng
│   │   │   │
│   │   │   ├── repositories/        # JPA Repositories
│   │   │   │   ├── CategoryRepository.java
│   │   │   │   ├── OrderDetailRepository.java
│   │   │   │   ├── OrderRepository.java
│   │   │   │   ├── ProductImageRepository.java
│   │   │   │   ├── ProductRepository.java
│   │   │   │   ├── RoleRepository.java
│   │   │   │   └── UserRepository.java
│   │   │   │
│   │   │   ├── responses/           # Response DTOs
│   │   │   │   ├── LoginResponse.java
│   │   │   │   ├── OrderDetailResponse.java
│   │   │   │   ├── OrderResponse.java
│   │   │   │   ├── ProductListResponse.java
│   │   │   │   └── ProductResponse.java
│   │   │   │
│   │   │   ├── services/            # Business logic
│   │   │   │   ├── IUserService.java
│   │   │   │   ├── UserService.java
│   │   │   │   ├── ICategoryService.java
│   │   │   │   ├── CategoryService.java
│   │   │   │   ├── IProductService.java
│   │   │   │   ├── ProductService.java
│   │   │   │   ├── IOrderService.java
│   │   │   │   ├── OrderService.java
│   │   │   │   └── ... (các service khác)
│   │   │   │
│   │   │   └── utils/               # Utility classes
│   │   │       └── MessageKeys.java          # Message keys cho i18n
│   │   │
│   │   └── resources/
│   │       ├── application.yml               # Cấu hình ứng dụng
│   │       └── i18nn/
│   │           ├── messages_en.properties    # Tiếng Anh
│   │           └── messages_vi.properties    # Tiếng Việt
│   │
│   └── test/                        # Test files
│
├── fake-data.sql                    # Dữ liệu mẫu (categories, users, products)
├── fake-data-part2.sql              # Dữ liệu mẫu (orders, order_details)
├── fake-data-part3.sql              # Dữ liệu mẫu (product_images)
├── init.sql                         # Script khởi tạo database
├── docker-compose.yml               # Docker orchestration
├── Dockerfile                       # Docker image config
├── .dockerignore                    # Docker ignore patterns
├── .env.example                     # Environment variables template
├── README-DOCKER.md                 # Hướng dẫn Docker (Vietnamese)
├── pom.xml                          # Maven dependencies
└── .gitignore                       # Git ignore patterns
```

## ⚙️ Cấu hình

### Database
- **Host:** localhost:3307
- **Database:** ShopApp
- **Username:** root
- **Password:** admin123
- **Charset:** UTF-8 (utf8mb4)

### API Configuration
- **Base URL:** http://localhost:8088
- **API Prefix:** /api/v1
- **Port:** 8088

### JWT Configuration
- **Expiration:** 30 days (2592000 seconds)
- **Algorithm:** HS256

## 🔧 Cài đặt & Chạy

### Cách 1: Sử dụng Docker (Khuyến nghị)

```bash
# 1. Clone repository
git clone <repository-url>
cd spring-backend

# 2. Copy file .env.example thành .env (tùy chọn)
cp .env.example .env

# 3. Khởi động Docker containers
docker-compose up -d

# 4. Kiểm tra logs
docker-compose logs -f backend

# 5. Import dữ liệu mẫu (optional)
docker exec -i shopapp-mysql mysql -uroot -padmin123 --default-character-set=utf8mb4 ShopApp < fake-data.sql
docker exec -i shopapp-mysql mysql -uroot -padmin123 --default-character-set=utf8mb4 ShopApp < fake-data-part2.sql
docker exec -i shopapp-mysql mysql -uroot -padmin123 --default-character-set=utf8mb4 ShopApp < fake-data-part3.sql
```

### Cách 2: Chạy Local

```bash
# 1. Cài đặt MySQL 8.0 và tạo database
CREATE DATABASE ShopApp CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# 2. Import schema từ init.sql
mysql -u root -p ShopApp < init.sql

# 3. Cấu hình application.yml (nếu cần)
# Chỉnh sửa datasource URL, username, password

# 4. Build và chạy
mvn clean package -DskipTests
java -jar target/shopapp-0.0.1-SNAPSHOT.jar

# Hoặc dùng Maven Spring Boot plugin
mvn spring-boot:run
```

## 📚 API Documentation

### Base URL
```
http://localhost:8088/api/v1
```

---

## 🔐 Authentication & Authorization

### 1. User Registration
Đăng ký tài khoản người dùng mới.

**Endpoint:** `POST /users/register`

**Request Body:**
```json
{
  "fullname": "Nguyễn Văn A",
  "phone_number": "0987654321",
  "address": "123 Đường ABC, Quận 1, TP.HCM",
  "password": "123456",
  "retype_password": "123456",
  "date_of_birth": "1990-01-01",
  "facebook_account_id": 0,
  "google_account_id": 0,
  "role_id": 1
}
```

**Response:** `200 OK`
```json
{
  "id": 1,
  "fullname": "Nguyễn Văn A",
  "phone_number": "0987654321",
  "address": "123 Đường ABC, Quận 1, TP.HCM",
  "role": {
    "id": 1,
    "name": "USER"
  }
}
```

**Validation:**
- `fullname`: Bắt buộc, độ dài 3-100 ký tự
- `phone_number`: Bắt buộc, phải là số điện thoại hợp lệ (10 chữ số)
- `password`: Bắt buộc, tối thiểu 6 ký tự
- `retype_password`: Phải khớp với password
- `role_id`: Bắt buộc (1 = USER, 2 = ADMIN)

---

### 2. User Login
Đăng nhập và nhận JWT token.

**Endpoint:** `POST /users/login`

**Request Body:**
```json
{
  "phone_number": "0987654321",
  "password": "123456"
}
```

**Response:** `200 OK`
```json
{
  "message": "Login successfully",
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjA5ODc2NTQzMjEiLCJzdWIiOiIwOTg3NjU0MzIxIiwiZXhwIjoxNzY2NzA1Mzk1fQ.xxx"
}
```

**Error Response:** `400 Bad Request`
```json
{
  "message": "Login failed: Tài khoản hoặc mật khẩu không đúng"
}
```

**Authentication Header cho các API khác:**
```
Authorization: Bearer {token}
```

---

## 👥 Roles API

### 3. Get All Roles
Lấy danh sách tất cả các vai trò.

**Endpoint:** `GET /roles`

**Authorization:** Public (không cần token)

**Response:** `200 OK`
```json
[
  {
    "id": 1,
    "name": "USER"
  },
  {
    "id": 2,
    "name": "ADMIN"
  }
]
```

---

## 📦 Categories API

### 4. Get All Categories
Lấy danh sách tất cả danh mục với phân trang.

**Endpoint:** `GET /categories`

**Query Parameters:**
- `page` (optional): Số trang (default: 0)
- `limit` (optional): Số items mỗi trang (default: 10)

**Authorization:** Public

**Example Request:**
```
GET /categories?page=0&limit=12
```

**Response:** `200 OK`
```json
[
  {
    "id": 1,
    "name": "Điện thoại"
  },
  {
    "id": 2,
    "name": "Laptop"
  },
  {
    "id": 3,
    "name": "Tablet"
  }
]
```

---

### 5. Create Category
Tạo danh mục mới.

**Endpoint:** `POST /categories`

**Authorization:** ADMIN role required

**Request Body:**
```json
{
  "name": "Smartwatch"
}
```

**Response:** `200 OK`
```json
{
  "id": 15,
  "name": "Smartwatch"
}
```

---

### 6. Update Category
Cập nhật thông tin danh mục.

**Endpoint:** `PUT /categories/{id}`

**Authorization:** ADMIN role required

**Request Body:**
```json
{
  "name": "Đồng hồ thông minh"
}
```

**Response:** `200 OK`
```json
{
  "id": 15,
  "name": "Đồng hồ thông minh"
}
```

---

### 7. Delete Category
Xóa danh mục.

**Endpoint:** `DELETE /categories/{id}`

**Authorization:** ADMIN role required

**Response:** `200 OK`
```json
{
  "message": "Delete category successfully"
}
```

---

## 📱 Products API

### 8. Get All Products
Lấy danh sách sản phẩm với phân trang và tìm kiếm.

**Endpoint:** `GET /products`

**Query Parameters:**
- `page` (optional): Số trang (default: 0)
- `limit` (optional): Số items mỗi trang (default: 10)
- `keyword` (optional): Từ khóa tìm kiếm theo tên sản phẩm
- `category_id` (optional): Lọc theo danh mục

**Authorization:** USER hoặc ADMIN role required

**Example Request:**
```
GET /products?page=0&limit=10&keyword=iPhone&category_id=1
```

**Response:** `200 OK`
```json
{
  "products": [
    {
      "id": 151,
      "name": "iPhone 15 Pro Max 256GB",
      "price": 29990000.0,
      "thumbnail": "iphone15promax.jpg",
      "description": "iPhone 15 Pro Max - Titan thiết kế cao cấp",
      "category_id": 1,
      "product_images": [
        {
          "id": 1,
          "image_url": "iphone15promax_1.jpg"
        },
        {
          "id": 2,
          "image_url": "iphone15promax_2.jpg"
        }
      ]
    }
  ],
  "total_pages": 15
}
```

---

### 9. Get Product by ID
Lấy thông tin chi tiết một sản phẩm.

**Endpoint:** `GET /products/{id}`

**Authorization:** USER hoặc ADMIN role required

**Response:** `200 OK`
```json
{
  "id": 151,
  "name": "iPhone 15 Pro Max 256GB",
  "price": 29990000.0,
  "thumbnail": "iphone15promax.jpg",
  "description": "iPhone 15 Pro Max với chip A17 Pro mạnh mẽ",
  "category_id": 1,
  "product_images": [
    {
      "id": 1,
      "image_url": "iphone15promax_1.jpg"
    }
  ]
}
```

---

### 10. Create Product
Tạo sản phẩm mới.

**Endpoint:** `POST /products`

**Authorization:** ADMIN role required

**Request Body:**
```json
{
  "name": "iPhone 15 Pro Max 256GB",
  "price": 29990000,
  "thumbnail": "iphone15promax.jpg",
  "description": "iPhone 15 Pro Max - Titan thiết kế cao cấp",
  "category_id": 1
}
```

**Validation:**
- `name`: Bắt buộc, độ dài 3-200 ký tự
- `price`: Bắt buộc, >= 0, <= 10,000,000
- `category_id`: Bắt buộc, phải tồn tại

**Response:** `200 OK`
```json
{
  "id": 151,
  "name": "iPhone 15 Pro Max 256GB",
  "price": 29990000.0,
  "thumbnail": "iphone15promax.jpg",
  "description": "iPhone 15 Pro Max - Titan thiết kế cao cấp",
  "category_id": 1
}
```

---

### 11. Update Product
Cập nhật thông tin sản phẩm.

**Endpoint:** `PUT /products/{id}`

**Authorization:** ADMIN role required

**Request Body:**
```json
{
  "name": "iPhone 15 Pro Max 512GB",
  "price": 34990000,
  "thumbnail": "iphone15promax512.jpg",
  "description": "iPhone 15 Pro Max bộ nhớ 512GB",
  "category_id": 1
}
```

**Response:** `200 OK`
```json
{
  "id": 151,
  "name": "iPhone 15 Pro Max 512GB",
  "price": 34990000.0,
  "thumbnail": "iphone15promax512.jpg",
  "description": "iPhone 15 Pro Max bộ nhớ 512GB",
  "category_id": 1
}
```

---

### 12. Delete Product
Xóa sản phẩm.

**Endpoint:** `DELETE /products/{id}`

**Authorization:** ADMIN role required

**Response:** `200 OK`
```json
{
  "message": "Product deleted successfully"
}
```

---

### 13. Upload Product Images
Upload nhiều hình ảnh cho sản phẩm.

**Endpoint:** `POST /products/uploads/{productId}`

**Authorization:** ADMIN role required

**Request:** `multipart/form-data`
- `files`: Danh sách file ảnh (tối đa 5 ảnh)

**Response:** `200 OK`
```json
[
  {
    "id": 1,
    "image_url": "product_151_1.jpg",
    "product_id": 151
  },
  {
    "id": 2,
    "image_url": "product_151_2.jpg",
    "product_id": 151
  }
]
```

**Validation:**
- Tối đa 5 ảnh
- Định dạng cho phép: jpg, jpeg, png
- Kích thước tối đa: 10MB per file

---

### 14. Get Product Image
Lấy file ảnh sản phẩm.

**Endpoint:** `GET /products/images/{imageName}`

**Authorization:** Public

**Response:** Image file (JPEG/PNG)

---

## 🛒 Orders API

### 15. Create Order
Tạo đơn hàng mới.

**Endpoint:** `POST /orders`

**Authorization:** USER role required

**Request Body:**
```json
{
  "user_id": 1,
  "fullname": "Nguyễn Văn A",
  "email": "nguyenvana@example.com",
  "phone_number": "0987654321",
  "address": "123 Đường ABC, Quận 1, TP.HCM",
  "note": "Giao hàng giờ hành chính",
  "total_money": 29990000,
  "shipping_method": "express",
  "shipping_address": "123 Đường ABC, Quận 1, TP.HCM",
  "payment_method": "cod",
  "cart_items": [
    {
      "product_id": 151,
      "quantity": 1
    }
  ]
}
```

**Validation:**
- `fullname`: Bắt buộc, tối thiểu 3 ký tự
- `email`: Email hợp lệ
- `phone_number`: Bắt buộc, 10 chữ số
- `address`: Bắt buộc, tối thiểu 5 ký tự
- `total_money`: >= 0
- `cart_items`: Mảng không rỗng

**Response:** `200 OK`
```json
{
  "id": 1,
  "user_id": 1,
  "fullname": "Nguyễn Văn A",
  "email": "nguyenvana@example.com",
  "phone_number": "0987654321",
  "address": "123 Đường ABC, Quận 1, TP.HCM",
  "status": "pending",
  "total_money": 29990000.0,
  "shipping_method": "express",
  "shipping_address": "123 Đường ABC, Quận 1, TP.HCM",
  "payment_method": "cod",
  "order_date": "2025-11-26T10:30:00"
}
```

---

### 16. Get Order by ID
Lấy thông tin chi tiết đơn hàng.

**Endpoint:** `GET /orders/{id}`

**Authorization:** USER (chỉ xem đơn của mình) hoặc ADMIN (xem tất cả)

**Response:** `200 OK`
```json
{
  "id": 1,
  "user_id": 1,
  "fullname": "Nguyễn Văn A",
  "phone_number": "0987654321",
  "address": "123 Đường ABC, Quận 1, TP.HCM",
  "status": "pending",
  "total_money": 29990000.0,
  "shipping_method": "express",
  "payment_method": "cod",
  "order_date": "2025-11-26T10:30:00",
  "order_details": [
    {
      "id": 1,
      "product_id": 151,
      "product_name": "iPhone 15 Pro Max 256GB",
      "price": 29990000.0,
      "number_of_products": 1,
      "total_money": 29990000.0
    }
  ]
}
```

---

### 17. Get Orders by User
Lấy danh sách đơn hàng của một user.

**Endpoint:** `GET /orders/user/{user_id}`

**Authorization:** USER (chỉ xem đơn của mình) hoặc ADMIN (xem tất cả)

**Response:** `200 OK`
```json
[
  {
    "id": 1,
    "fullname": "Nguyễn Văn A",
    "status": "pending",
    "total_money": 29990000.0,
    "order_date": "2025-11-26T10:30:00"
  },
  {
    "id": 2,
    "fullname": "Nguyễn Văn A",
    "status": "delivered",
    "total_money": 15990000.0,
    "order_date": "2025-11-20T14:20:00"
  }
]
```

---

### 18. Update Order
Cập nhật thông tin đơn hàng.

**Endpoint:** `PUT /orders/{id}`

**Authorization:** ADMIN role required

**Request Body:**
```json
{
  "user_id": 1,
  "fullname": "Nguyễn Văn A",
  "email": "nguyenvana@example.com",
  "phone_number": "0987654321",
  "address": "456 Đường XYZ, Quận 2, TP.HCM",
  "status": "shipping",
  "total_money": 29990000,
  "shipping_method": "express",
  "shipping_address": "456 Đường XYZ, Quận 2, TP.HCM",
  "payment_method": "cod"
}
```

**Response:** `200 OK`

**Order Status Values:**
- `pending`: Chờ xử lý
- `processing`: Đang xử lý
- `shipped`: Đã giao cho vận chuyển
- `delivered`: Đã giao hàng
- `cancelled`: Đã hủy

---

### 19. Delete Order
Xóa đơn hàng (soft delete).

**Endpoint:** `DELETE /orders/{id}`

**Authorization:** ADMIN role required

**Response:** `200 OK`
```json
{
  "message": "Order deleted successfully"
}
```

---

## 📋 Order Details API

### 20. Create Order Detail
Tạo chi tiết đơn hàng mới.

**Endpoint:** `POST /order_details`

**Authorization:** USER role required

**Request Body:**
```json
{
  "order_id": 1,
  "product_id": 151,
  "price": 29990000,
  "number_of_products": 1,
  "total_money": 29990000,
  "color": "Titan tự nhiên"
}
```

**Response:** `200 OK`
```json
{
  "id": 1,
  "order_id": 1,
  "product_id": 151,
  "price": 29990000.0,
  "number_of_products": 1,
  "total_money": 29990000.0,
  "color": "Titan tự nhiên"
}
```

---

### 21. Get Order Detail by ID
Lấy thông tin chi tiết một order detail.

**Endpoint:** `GET /order_details/{id}`

**Authorization:** USER hoặc ADMIN role required

**Response:** `200 OK`
```json
{
  "id": 1,
  "order_id": 1,
  "product_id": 151,
  "product_name": "iPhone 15 Pro Max 256GB",
  "price": 29990000.0,
  "number_of_products": 1,
  "total_money": 29990000.0,
  "color": "Titan tự nhiên"
}
```

---

### 22. Get Order Details by Order ID
Lấy tất cả chi tiết của một đơn hàng.

**Endpoint:** `GET /order_details/order/{orderId}`

**Authorization:** USER hoặc ADMIN role required

**Response:** `200 OK`
```json
[
  {
    "id": 1,
    "order_id": 1,
    "product_id": 151,
    "product_name": "iPhone 15 Pro Max 256GB",
    "price": 29990000.0,
    "number_of_products": 1,
    "total_money": 29990000.0,
    "color": "Titan tự nhiên"
  },
  {
    "id": 2,
    "order_id": 1,
    "product_id": 152,
    "product_name": "iPhone 15 Pro 128GB",
    "price": 24990000.0,
    "number_of_products": 1,
    "total_money": 24990000.0,
    "color": "Xanh titan"
  }
]
```

---

### 23. Update Order Detail
Cập nhật chi tiết đơn hàng.

**Endpoint:** `PUT /order_details/{id}`

**Authorization:** ADMIN role required

**Request Body:**
```json
{
  "order_id": 1,
  "product_id": 151,
  "price": 29990000,
  "number_of_products": 2,
  "total_money": 59980000,
  "color": "Titan tự nhiên"
}
```

**Response:** `200 OK`

---

### 24. Delete Order Detail
Xóa chi tiết đơn hàng.

**Endpoint:** `DELETE /order_details/{id}`

**Authorization:** ADMIN role required

**Response:** `200 OK`
```json
{
  "message": "Order detail deleted successfully"
}
```

---

## 🔒 Phân quyền và Bảo mật

### Roles
- **USER**: Người dùng thông thường
  - Xem danh mục, sản phẩm
  - Tạo và quản lý đơn hàng của mình

- **ADMIN**: Quản trị viên
  - Toàn quyền quản lý categories, products
  - Quản lý tất cả orders
  - Cập nhật trạng thái đơn hàng

### Public Endpoints (Không cần token)
- `POST /users/register`
- `POST /users/login`
- `GET /roles`
- `GET /categories` (read only)
- `GET /products/images/{imageName}`

### Protected Endpoints
Tất cả các endpoint khác đều yêu cầu JWT token trong header:
```
Authorization: Bearer {your_jwt_token}
```

### CORS Configuration
- Allowed Origins: `*` (tất cả origins)
- Allowed Methods: `GET`, `POST`, `PUT`, `DELETE`, `OPTIONS`
- Allowed Headers: `authorization`, `content-type`, `x-auth-token`

---

## 🌐 Đa ngôn ngữ (i18n)

API hỗ trợ 2 ngôn ngữ:
- **Tiếng Việt** (vi)
- **Tiếng Anh** (en)

Thêm header để chọn ngôn ngữ:
```
Accept-Language: vi
```

hoặc
```
Accept-Language: en
```

---

## 🗄️ Database Schema

### Tables

#### users
- `id` (PK)
- `fullname`
- `phone_number` (unique)
- `address`
- `password` (BCrypt hashed)
- `created_at`
- `updated_at`
- `is_active`
- `date_of_birth`
- `facebook_account_id`
- `google_account_id`
- `role_id` (FK -> roles)

#### roles
- `id` (PK)
- `name` (USER, ADMIN)

#### categories
- `id` (PK)
- `name`

#### products
- `id` (PK)
- `name`
- `price`
- `thumbnail`
- `description`
- `created_at`
- `updated_at`
- `category_id` (FK -> categories)

#### product_images
- `id` (PK)
- `product_id` (FK -> products)
- `image_url`

#### orders
- `id` (PK)
- `user_id` (FK -> users)
- `fullname`
- `email`
- `phone_number`
- `address`
- `note`
- `order_date`
- `status` (pending, processing, shipped, delivered, cancelled)
- `total_money`
- `shipping_method`
- `shipping_address`
- `shipping_date`
- `tracking_number`
- `payment_method`
- `active`

#### order_details
- `id` (PK)
- `order_id` (FK -> orders)
- `product_id` (FK -> products)
- `price`
- `number_of_products`
- `total_money`
- `color`

---

## 🧪 Testing

### Test với cURL

#### Login
```bash
curl -X POST http://localhost:8088/api/v1/users/login \
  -H "Content-Type: application/json" \
  -d '{
    "phone_number": "0901234567",
    "password": "123456"
  }'
```

#### Get Categories
```bash
curl http://localhost:8088/api/v1/categories?page=0&limit=10
```

#### Get Products (với authentication)
```bash
curl http://localhost:8088/api/v1/products?page=0&limit=10 \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

### Test với Postman
Import collection từ file hoặc tạo requests theo API documentation trên.

---

## 📦 Dữ liệu mẫu

Sau khi khởi động, import dữ liệu mẫu:

```bash
# Import categories, users, products
docker exec -i shopapp-mysql mysql -uroot -padmin123 --default-character-set=utf8mb4 ShopApp < fake-data.sql

# Import orders, order_details
docker exec -i shopapp-mysql mysql -uroot -padmin123 --default-character-set=utf8mb4 ShopApp < fake-data-part2.sql

# Import product_images
docker exec -i shopapp-mysql mysql -uroot -padmin123 --default-character-set=utf8mb4 ShopApp < fake-data-part3.sql
```

**Dữ liệu mẫu bao gồm:**
- 15 categories
- 53 users (password mặc định: `123456`)
- 150 products
- 96 orders với nhiều trạng thái khác nhau
- 100 order details
- 231 product images

**Test Accounts:**
```
Phone: 0901234567
Password: 123456
Role: USER

Phone: 0901234568
Password: 123456
Role: USER
```

---

## 🚨 Xử lý lỗi

### Error Response Format
```json
{
  "message": "Error message in Vietnamese or English",
  "details": "Additional error details (optional)"
}
```

### Common HTTP Status Codes
- `200 OK`: Thành công
- `400 Bad Request`: Dữ liệu không hợp lệ
- `401 Unauthorized`: Chưa xác thực
- `403 Forbidden`: Không có quyền truy cập
- `404 Not Found`: Không tìm thấy resource
- `500 Internal Server Error`: Lỗi server

---

## 🐛 Troubleshooting

### Lỗi kết nối database
```bash
# Kiểm tra MySQL container
docker ps

# Xem logs
docker logs shopapp-mysql

# Restart containers
docker-compose restart
```

### Lỗi 403 khi gọi API
- Kiểm tra JWT token có hợp lệ không
- Kiểm tra role có phù hợp với endpoint không
- Kiểm tra token chưa hết hạn (30 days)

### Tiếng Việt hiển thị sai
- Đảm bảo database charset là `utf8mb4`
- Import data với flag `--default-character-set=utf8mb4`

---

## 📝 Changelog

### Version 1.0.0 (2025-11-26)
- ✅ Khởi tạo project với Spring Boot 3.3.3
- ✅ JWT Authentication & Authorization
- ✅ CRUD cho Users, Categories, Products, Orders
- ✅ Upload product images
- ✅ Docker support
- ✅ Multi-language support (Vietnamese/English)
- ✅ UTF-8 encoding fix
- ✅ CORS configuration
- ✅ Fake data generation

---

## 👥 Contributors

- Developer: [Your Name]
- Contact: [Your Email]

---

## 📄 License

This project is licensed under the MIT License.

---

## 🔗 Related Links

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [Spring Security](https://spring.io/projects/spring-security)
- [JWT](https://jwt.io/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Docker Documentation](https://docs.docker.com/)

---

**Happy Coding! 🚀**
