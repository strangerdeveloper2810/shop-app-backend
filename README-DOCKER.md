conn# Hướng Dẫn Setup ShopApp Backend với Docker

## Mục lục
- [Yêu cầu hệ thống](#yêu-cầu-hệ-thống)
- [Cấu trúc Docker](#cấu-trúc-docker)
- [Cài đặt và Chạy](#cài-đặt-và-chạy)
- [Cấu hình](#cấu-hình)
- [API Endpoints](#api-endpoints)
- [Troubleshooting](#troubleshooting)
- [Production Deployment](#production-deployment)

---

## Yêu cầu hệ thống

Trước khi bắt đầu, đảm bảo máy bạn đã cài đặt:

- **Docker**: version 20.10 trở lên
- **Docker Compose**: version 2.0 trở lên

Kiểm tra version:
```bash
docker --version
docker-compose --version
```

---

## Cấu trúc Docker

Dự án sử dụng Docker Compose với 2 services chính:

### 1. MySQL Database (`mysql`)
- **Image**: mysql:8.0
- **Port**: 3307 (host) → 3306 (container)
- **Database**: ShopApp
- **User**: shopapp / shopapp123
- **Root Password**: admin123
- **Volume**: `mysql_data` để lưu trữ persistent data

### 2. Spring Boot Backend (`backend`)
- **Base Image**: Eclipse Temurin Java 17
- **Port**: 8088 (host) → 8088 (container)
- **Volume**: `./uploads` để lưu ảnh sản phẩm
- **Dependencies**: Chờ MySQL healthy trước khi start

### Network
- **shopapp-network**: Bridge network để các container giao tiếp với nhau

---

## Cài đặt và Chạy

### Bước 1: Clone và Di chuyển vào thư mục dự án
```bash
cd /Users/mdm/Desktop/angular-spring/spring-backend
```

### Bước 2: Tạo file cấu hình môi trường
```bash
# Copy file .env.example thành .env
cp .env.example .env

# Chỉnh sửa file .env nếu cần (optional)
nano .env
```

### Bước 3: Tạo thư mục uploads
```bash
mkdir -p uploads
```

### Bước 4: Build và Start services
```bash
# Build và start tất cả services
docker-compose up -d --build

# Hoặc start mà không rebuild (nếu đã build trước đó)
docker-compose up -d
```

### Bước 5: Kiểm tra logs
```bash
# Xem logs của tất cả services
docker-compose logs -f

# Xem logs của backend
docker-compose logs -f backend

# Xem logs của mysql
docker-compose logs -f mysql
```

### Bước 6: Kiểm tra services đang chạy
```bash
docker-compose ps
```

Kết quả mong đợi:
```
NAME                IMAGE               STATUS              PORTS
shopapp-backend     spring-backend      Up 2 minutes        0.0.0.0:8088->8088/tcp
shopapp-mysql       mysql:8.0           Up 2 minutes        0.0.0.0:3307->3306/tcp
```

### Bước 7: Kiểm tra API
```bash
# Test health check
curl http://localhost:8088/api/v1/roles

# Hoặc mở browser
open http://localhost:8088/api/v1/roles
```

---

## Cấu hình

### File `.env`

Các biến môi trường quan trọng:

```env
# Database
MYSQL_ROOT_PASSWORD=admin123        # Root password cho MySQL
MYSQL_DATABASE=ShopApp              # Tên database
MYSQL_USER=shopapp                  # Username cho application
MYSQL_PASSWORD=shopapp123           # Password cho application user
MYSQL_PORT=3307                     # Port expose ra host

# Backend
BACKEND_PORT=8088                   # Port expose ra host

# JPA/Hibernate
DDL_AUTO=update                     # update: tự động tạo/update tables
                                    # validate: chỉ validate schema
                                    # none: không làm gì
SHOW_SQL=true                       # Hiển thị SQL queries trong logs

# JWT
JWT_SECRET_KEY=ALCbi60PiwHV8ZPsBKZJzAVe+E3rWN5DLzww7hg6Tj8=
JWT_EXPIRATION=2592000              # 30 ngày (tính bằng giây)

# Locale
DEFAULT_LOCALE=en                   # en hoặc vi
```

### Database Schema

Database schema sẽ được tự động tạo bởi Hibernate khi `DDL_AUTO=update`.

Initial data (roles, categories, admin user) được tạo từ file `init.sql`.

**Default Admin Account:**
- Phone: `0123456789`
- Password: `admin123`

⚠️ **Lưu ý**: Đổi password admin sau khi login lần đầu!

---

## Các Lệnh Thường Dùng

### Khởi động services
```bash
docker-compose up -d
```

### Dừng services
```bash
docker-compose down
```

### Dừng và xóa volumes (reset toàn bộ data)
```bash
docker-compose down -v
```

### Rebuild services
```bash
docker-compose up -d --build
```

### Restart một service cụ thể
```bash
docker-compose restart backend
```

### Xem logs real-time
```bash
docker-compose logs -f backend
```

### Truy cập vào container
```bash
# Truy cập backend container
docker exec -it shopapp-backend sh

# Truy cập MySQL container
docker exec -it shopapp-mysql bash
```

### Kết nối MySQL từ host
```bash
mysql -h 127.0.0.1 -P 3307 -u shopapp -p
# Nhập password: shopapp123
```

### Backup database
```bash
docker exec shopapp-mysql mysqldump -u root -padmin123 ShopApp > backup.sql
```

### Restore database
```bash
docker exec -i shopapp-mysql mysql -u root -padmin123 ShopApp < backup.sql
```

---

## API Endpoints

Base URL: `http://localhost:8088/api/v1`

### Authentication

#### Đăng ký user mới
```bash
curl -X POST http://localhost:8088/api/v1/users/register \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "Nguyen Van A",
    "phoneNumber": "0987654321",
    "password": "123456",
    "retypePassword": "123456",
    "address": "Ha Noi",
    "roleId": 1
  }'
```

#### Đăng nhập
```bash
curl -X POST http://localhost:8088/api/v1/users/login \
  -H "Content-Type: application/json" \
  -d '{
    "phoneNumber": "0123456789",
    "password": "admin123"
  }'
```

Response sẽ chứa JWT token:
```json
{
  "message": "Login successfully",
  "token": "eyJhbGciOiJIUzI1NiJ9..."
}
```

### Protected Endpoints

Sử dụng JWT token trong header:
```bash
curl -X GET http://localhost:8088/api/v1/products \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

### Danh sách Endpoints chính:

| Method | Endpoint | Mô tả | Auth | Role |
|--------|----------|-------|------|------|
| POST | `/users/register` | Đăng ký | No | - |
| POST | `/users/login` | Đăng nhập | No | - |
| GET | `/roles` | Lấy danh sách roles | No | - |
| GET | `/categories` | Lấy danh mục | Yes | USER/ADMIN |
| POST | `/categories` | Tạo danh mục | Yes | ADMIN |
| GET | `/products` | Lấy sản phẩm | Yes | USER/ADMIN |
| POST | `/products` | Tạo sản phẩm | Yes | ADMIN |
| POST | `/products/uploads/{id}` | Upload ảnh | Yes | ADMIN |
| GET | `/products/images/{name}` | Xem ảnh | No | - |
| POST | `/orders` | Tạo đơn hàng | Yes | USER |
| GET | `/orders/user/{id}` | Đơn hàng của user | Yes | USER/ADMIN |

---

## Troubleshooting

### 1. Backend không connect được MySQL

**Triệu chứng:**
```
com.mysql.cj.jdbc.exceptions.CommunicationsException: Communications link failure
```

**Giải pháp:**
```bash
# Kiểm tra MySQL đã healthy chưa
docker-compose ps

# Kiểm tra logs MySQL
docker-compose logs mysql

# Restart services
docker-compose restart
```

### 2. Port đã được sử dụng

**Triệu chứng:**
```
Error: bind: address already in use
```

**Giải pháp:**
```bash
# Tìm process đang dùng port 8088
lsof -i :8088

# Kill process đó
kill -9 <PID>

# Hoặc đổi port trong file .env
BACKEND_PORT=8089
```

### 3. Backend container exit ngay sau khi start

**Giải pháp:**
```bash
# Xem logs để biết lỗi
docker-compose logs backend

# Kiểm tra MySQL đã sẵn sàng chưa
docker-compose logs mysql | grep "ready for connections"

# Rebuild nếu cần
docker-compose up -d --build
```

### 4. Tables không được tạo tự động

**Giải pháp:**
```bash
# Đảm bảo DDL_AUTO=update trong .env
echo "DDL_AUTO=update" >> .env

# Restart backend
docker-compose restart backend

# Hoặc tạo tables manually từ init.sql
docker exec -i shopapp-mysql mysql -u root -padmin123 ShopApp < init.sql
```

### 5. Upload ảnh lỗi "Permission denied"

**Giải pháp:**
```bash
# Đảm bảo thư mục uploads có quyền đúng
chmod -R 755 uploads

# Hoặc tạo lại thư mục
rm -rf uploads && mkdir uploads
```

### 6. Out of memory khi build

**Giải pháp:**
```bash
# Tăng memory cho Docker Desktop
# Settings → Resources → Memory → Tăng lên 4GB hoặc hơn

# Hoặc build trên host rồi copy jar vào
./mvnw clean package -DskipTests
docker-compose up -d
```

### 7. Xem logs chi tiết

```bash
# Backend logs với timestamp
docker-compose logs -f --timestamps backend

# MySQL error logs
docker exec shopapp-mysql tail -f /var/log/mysql/error.log

# Spring Boot debug logs
# Thêm vào docker-compose.yml:
# environment:
#   LOGGING_LEVEL_ROOT=DEBUG
```

---

## Production Deployment

### 1. Security Checklist

⚠️ **QUAN TRỌNG**: Trước khi deploy production:

- [ ] Đổi tất cả passwords mặc định
- [ ] Generate JWT secret key mới
- [ ] Set `DDL_AUTO=validate` hoặc `none`
- [ ] Disable `SHOW_SQL=false`
- [ ] Sử dụng environment variables thay vì hardcode
- [ ] Setup SSL/TLS cho MySQL
- [ ] Setup HTTPS cho backend
- [ ] Giới hạn CORS origins
- [ ] Enable rate limiting
- [ ] Setup monitoring và logging
- [ ] Backup database định kỳ

### 2. Environment Variables cho Production

```env
# Database
MYSQL_ROOT_PASSWORD=<strong-random-password>
MYSQL_DATABASE=ShopApp
MYSQL_USER=shopapp
MYSQL_PASSWORD=<strong-random-password>

# Backend
BACKEND_PORT=8088

# JPA
DDL_AUTO=validate                   # KHÔNG dùng update trong production
SHOW_SQL=false                      # Tắt SQL logging

# JWT
JWT_SECRET_KEY=<generate-new-secret-256-bit>
JWT_EXPIRATION=2592000

# Locale
DEFAULT_LOCALE=en
```

### 3. Generate JWT Secret Key

```bash
# Sử dụng OpenSSL
openssl rand -base64 32

# Hoặc sử dụng Node.js
node -e "console.log(require('crypto').randomBytes(32).toString('base64'))"
```

### 4. Database Migrations

Sử dụng Flyway hoặc Liquibase để quản lý database schema:

```xml
<!-- pom.xml -->
<dependency>
    <groupId>org.flywaydb</groupId>
    <artifactId>flyway-core</artifactId>
</dependency>
```

### 5. Docker Compose Production

Tạo file `docker-compose.prod.yml`:

```yaml
version: '3.8'

services:
  mysql:
    image: mysql:8.0
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    volumes:
      - mysql_data:/var/lib/mysql
    networks:
      - shopapp-network
    # Không expose port ra ngoài

  backend:
    image: shopapp-backend:latest
    restart: always
    environment:
      SPRING_DATASOURCE_URL: jdbc:mysql://mysql:3306/${MYSQL_DATABASE}
      SPRING_DATASOURCE_USERNAME: ${MYSQL_USER}
      SPRING_DATASOURCE_PASSWORD: ${MYSQL_PASSWORD}
      SPRING_JPA_HIBERNATE_DDL_AUTO: validate
      SPRING_JPA_SHOW_SQL: false
      JWT_SECRET_KEY: ${JWT_SECRET_KEY}
    ports:
      - "8088:8088"
    depends_on:
      - mysql
    networks:
      - shopapp-network

volumes:
  mysql_data:

networks:
  shopapp-network:
    driver: bridge
```

### 6. Monitoring

Setup monitoring với Prometheus + Grafana:

```yaml
# docker-compose.monitoring.yml
services:
  prometheus:
    image: prom/prometheus
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    ports:
      - "9090:9090"

  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
```

---

## Kiến trúc Hệ thống

```
┌─────────────────┐
│   Angular       │
│   Frontend      │
│  (localhost)    │
└────────┬────────┘
         │ HTTP/HTTPS
         │ Port 8088
         ▼
┌─────────────────────────┐
│  Docker Network         │
│  (shopapp-network)      │
│                         │
│  ┌───────────────┐      │
│  │  Spring Boot  │      │
│  │   Backend     │      │
│  │   :8088       │      │
│  └───────┬───────┘      │
│          │ JDBC         │
│          ▼              │
│  ┌───────────────┐      │
│  │    MySQL      │      │
│  │    :3306      │      │
│  │  (ShopApp DB) │      │
│  └───────────────┘      │
│                         │
└─────────────────────────┘

Volumes:
- mysql_data (persistent)
- ./uploads (mounted)
```

---

## Tài Nguyên Bổ Sung

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Spring Boot with Docker](https://spring.io/guides/topicals/spring-boot-docker)
- [MySQL Docker Hub](https://hub.docker.com/_/mysql)

---

## Liên Hệ & Support

Nếu gặp vấn đề, hãy:
1. Kiểm tra phần [Troubleshooting](#troubleshooting)
2. Xem logs: `docker-compose logs -f`
3. Tạo issue trên GitHub repository

---

**Happy Coding!** 🚀
