# ShopApp Backend - Hướng Dẫn Tổng Quan

> Tài liệu này giúp bạn nhanh chóng nhớ lại toàn bộ dự án sau thời gian dài không làm việc với nó.

---

## Mục Lục

1. [Tổng Quan Kiến Trúc](#1-tổng-quan-kiến-trúc)
2. [Cách Chạy Dự Án](#2-cách-chạy-dự-án)
3. [Database - Các Bảng & Quan Hệ](#3-database---các-bảng--quan-hệ)
4. [Java Core - Những Khái Niệm Cần Nhớ](#4-java-core---những-khái-niệm-cần-nhớ)
5. [Spring Boot - Giải Thích Từng Layer](#5-spring-boot---giải-thích-từng-layer)
6. [Security - JWT Authentication](#6-security---jwt-authentication)
7. [Luồng Xử Lý Một Request](#7-luồng-xử-lý-một-request)
8. [Danh Sách API](#8-danh-sách-api)
9. [Cấu Trúc Thư Mục](#9-cấu-trúc-thư-mục)

---

## 1. Tổng Quan Kiến Trúc

```
Client (Angular/React/Postman)
        | HTTP Request (JSON)
        v
+--------------------------------------------------+
|              SPRING BOOT APPLICATION              |
|                                                   |
|  +------------------+                             |
|  | JwtTokenFilter   |  <-- Kiểm tra JWT token    |
|  +--------+---------+      trước mỗi request      |
|           |                                       |
|  +--------v---------+                             |
|  | Controller        |  <-- Nhận request,         |
|  | (@RestController) |      validate input        |
|  +--------+----------+                            |
|           |                                       |
|  +--------v---------+                             |
|  | Service           |  <-- Xử lý business logic  |
|  | (Interface + Impl)|                            |
|  +--------+----------+                            |
|           |                                       |
|  +--------v---------+                             |
|  | Repository        |  <-- Tương tác database    |
|  | (JpaRepository)   |      (SQL tự động)         |
|  +--------+----------+                            |
+-----------|--------------------------------------+
            |
            v
     MySQL / PostgreSQL
```

**Nguyên tắc:** Mỗi layer chỉ giao tiếp với layer liền kề. Controller KHÔNG được gọi trực tiếp Repository.

---

## 2. Cách Chạy Dự Án

### Yêu cầu:
- Java 17
- Docker (cho MySQL)

### Bước 1: Chạy MySQL

```bash
docker-compose up -d
```

MySQL sẽ chạy ở port **3307** (không phải 3306 mặc định), database tên **ShopApp**.

Thông tin kết nối:
- Host: `localhost:3307`
- Username: `root`
- Password: `admin123`
- Database: `ShopApp`

### Bước 2: Chạy Spring Boot

```bash
./mvnw spring-boot:run
```

App chạy ở port **8088**: `http://localhost:8088`

### Bước 3: Test thử

```bash
# Đăng nhập (lấy JWT token)
curl -X POST http://localhost:8088/api/v1/users/login \
  -H "Content-Type: application/json" \
  -d '{"phone_number":"0123456789", "password":"123456"}'

# Xem sản phẩm (không cần token)
curl http://localhost:8088/api/v1/products?page=0\&limit=10

# Xem danh mục (không cần token)
curl http://localhost:8088/api/v1/categories
```

### Tài khoản admin mặc định:
- Phone: `0123456789`
- Password: `123456`
- Role: ADMIN

---

## 3. Database - Các Bảng & Quan Hệ

### Sơ đồ quan hệ

```
roles (1) --------< (N) users (1) --------< (N) orders
                                                    |
                                                    | (1)
                                                    |
categories (1) ---< (N) products (1) --< (N) order_details
                            |
                            | (1)
                            |
                     product_images (N)
```

### Chi tiết từng bảng

#### `roles` - Vai trò người dùng
| Cột    | Kiểu    | Ghi chú                  |
|--------|---------|--------------------------|
| id     | BIGINT  | PK, auto increment       |
| name   | VARCHAR | "USER" hoặc "ADMIN"     |

Chỉ có 2 role: USER (mua hàng) và ADMIN (quản lý).

#### `users` - Người dùng
| Cột                 | Kiểu      | Ghi chú                       |
|---------------------|-----------|-------------------------------|
| id                  | BIGINT    | PK                            |
| fullname            | VARCHAR   |                               |
| phone_number        | VARCHAR   | Unique, dùng để đăng nhập    |
| password            | VARCHAR   | Mã hóa BCrypt                |
| address             | VARCHAR   |                               |
| is_active           | BOOLEAN   | Tài khoản còn hoạt động?     |
| date_of_birth       | DATE      |                               |
| facebook_account_id | INT       | 0 = không đăng nhập bằng FB  |
| google_account_id   | INT       | 0 = không đăng nhập bằng GG  |
| role_id             | BIGINT    | FK -> roles.id               |
| created_at          | DATETIME  | Tự động (BaseEntity)         |
| updated_at          | DATETIME  | Tự động (BaseEntity)         |

**Lưu ý:** Đăng nhập bằng phone number (không phải email).

#### `categories` - Danh mục sản phẩm
| Cột    | Kiểu    | Ghi chú       |
|--------|---------|---------------|
| id     | BIGINT  | PK            |
| name   | VARCHAR | Tên danh mục  |

Dữ liệu seed: Điện thoại, Laptop, Phụ kiện, Tablet, Smartwatch.

#### `products` - Sản phẩm
| Cột         | Kiểu    | Ghi chú             |
|-------------|---------|---------------------|
| id          | BIGINT  | PK                  |
| name        | VARCHAR | Tên sản phẩm       |
| price       | FLOAT   |                     |
| thumbnail   | VARCHAR | Ảnh đại diện       |
| description | VARCHAR | Mô tả              |
| category_id | BIGINT  | FK -> categories.id |
| created_at  | DATETIME| Tự động            |
| updated_at  | DATETIME| Tự động            |

#### `product_images` - Ảnh sản phẩm
| Cột        | Kiểu    | Ghi chú                        |
|------------|---------|--------------------------------|
| id         | BIGINT  | PK                             |
| product_id | BIGINT  | FK -> products.id              |
| image_url  | VARCHAR | Đường dẫn file                 |

**Giới hạn:** Mỗi sản phẩm tối đa 5 ảnh (`MAXIMUM_IMAGES_PER_PRODUCT = 5`).

#### `orders` - Đơn hàng
| Cột              | Kiểu    | Ghi chú                           |
|------------------|---------|-----------------------------------|
| id               | BIGINT  | PK                                |
| user_id          | BIGINT  | FK -> users.id                    |
| fullname         | VARCHAR | Tên người nhận                   |
| email            | VARCHAR |                                   |
| phone_number     | VARCHAR | SĐT người nhận                  |
| address          | VARCHAR | Địa chỉ nhận                    |
| note             | VARCHAR | Ghi chú                          |
| order_date       | DATE    | Ngày đặt                         |
| status           | VARCHAR | "pending", "processing", "shipped", "delivered", "cancelled" |
| total_money      | FLOAT   | Tổng tiền                        |
| shipping_method  | VARCHAR | Phương thức vận chuyển           |
| shipping_address | VARCHAR |                                   |
| shipping_date    | DATE    | Phải >= ngày hôm nay             |
| tracking_number  | VARCHAR | Mã vận đơn                       |
| payment_method   | VARCHAR | Phương thức thanh toán           |
| active           | BOOLEAN | `false` = đã xóa mềm (soft delete)|

**Soft delete:** Khi xóa đơn hàng, chỉ set `active = false`, KHÔNG xóa khỏi DB.

#### `order_details` - Chi tiết đơn hàng
| Cột                | Kiểu  | Ghi chú            |
|--------------------|-------|--------------------|
| id                 | BIGINT| PK                 |
| order_id           | BIGINT| FK -> orders.id    |
| product_id         | BIGINT| FK -> products.id  |
| price              | FLOAT | Giá tại thời điểm  |
| number_of_products | INT   | Số lượng           |
| total_money        | FLOAT | = price * số lượng |
| color              | VARCHAR| Màu sắc           |

---

## 4. Java Core - Những Khái Niệm Cần Nhớ

### 4.1 Lombok - Giảm boilerplate code

Thay vì viết getter/setter/constructor thủ công, dùng annotation:

```java
// KHÔNG có Lombok - phải viết 50+ dòng
public class Product {
    private String name;
    private Float price;

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Float getPrice() { return price; }
    public void setPrice(Float price) { this.price = price; }
    public Product() {}
    public Product(String name, Float price) { ... }
    // ... toString, equals, hashCode ...
}

// CÓ Lombok - chỉ cần 5 dòng
@Data                   // = @Getter + @Setter + @ToString + @EqualsAndHashCode
@Builder                // Cho phép: Product.builder().name("X").price(100).build()
@NoArgsConstructor      // Constructor không tham số: new Product()
@AllArgsConstructor     // Constructor đầy đủ: new Product("X", 100)
public class Product {
    private String name;
    private Float price;
}
```

| Annotation              | Tác dụng                                         |
|-------------------------|--------------------------------------------------|
| `@Data`                 | Getter + Setter + toString + equals + hashCode   |
| `@Builder`              | Builder pattern: `.name("X").price(100).build()` |
| `@NoArgsConstructor`    | Constructor rỗng                                 |
| `@AllArgsConstructor`   | Constructor với tất cả field                     |
| `@RequiredArgsConstructor`| Constructor cho các field `final` (dùng cho DI)|

### 4.2 Optional - Tránh NullPointerException

```java
// Cách cũ (dễ bị NPE)
User user = userRepository.findById(id);  // có thể null!
user.getName();  // BOOM! NullPointerException

// Cách mới với Optional
Optional<User> optionalUser = userRepository.findById(id);

// Cách 1: orElseThrow - ném exception nếu không tìm thấy
User user = userRepository.findById(id)
    .orElseThrow(() -> new DataNotFoundException("User not found"));

// Cách 2: orElse - trả về giá trị mặc định
User user = userRepository.findById(id).orElse(null);

// Cách 3: ifPresent - làm gì đó nếu có giá trị
userRepository.findById(id).ifPresent(user -> {
    System.out.println(user.getName());
});
```

### 4.3 Stream API - Xử lý collections

```java
// Lọc danh sách lỗi validation
List<String> errorMessages = result.getFieldErrors()
    .stream()                              // Tạo stream từ list
    .map(FieldError::getDefaultMessage)    // Lấy message từ mỗi lỗi
    .toList();                             // Chuyển về List<String>

// Tương đương với vòng for:
List<String> errorMessages = new ArrayList<>();
for (FieldError error : result.getFieldErrors()) {
    errorMessages.add(error.getDefaultMessage());
}
```

### 4.4 Generics (Kiểu tổng quát)

```java
// JpaRepository<Product, Long> nghĩa là:
//   - Product: kiểu entity
//   - Long: kiểu của primary key (id)
public interface ProductRepository extends JpaRepository<Product, Long> {
    // Tự động có: findById(Long id), save(Product p), deleteById(Long id), ...
}

// ResponseEntity<?> nghĩa là:
//   - ? = wildcard, có thể trả về bất kỳ kiểu gì
//   - Vì success trả Product, fail trả String (error message)
public ResponseEntity<?> createProduct(...) {
    // Thành công: trả Product object
    return ResponseEntity.ok(newProduct);
    // Thất bại: trả String
    return ResponseEntity.badRequest().body("Error message");
}
```

### 4.5 Interface - "Hợp đồng" giữa các class

```java
// Interface định nghĩa "hợp đồng" - PHẢI làm những gì
public interface IProductService {
    Product createProduct(ProductDTO dto) throws DataNotFoundException;
    Product getProductById(long id) throws DataNotFoundException;
}

// Implementation - làm NHƯ THẾ NÀO
@Service
public class ProductService implements IProductService {
    @Override
    public Product createProduct(ProductDTO dto) throws DataNotFoundException {
        // ... code thực tế ...
    }
}

// Controller chỉ biết interface, không biết implementation cụ thể
public class ProductController {
    private final IProductService productService;  // Interface, không phải ProductService
}
```

**Tại sao?**
- Dễ test (tạo mock implementation)
- Dễ thay đổi (swap sang implementation khác mà không sửa Controller)
- Tuân thủ nguyên lý SOLID (Dependency Inversion)

---

## 5. Spring Boot - Giải Thích Từng Layer

### 5.1 Model (Entity) - Ánh xạ bảng DB

Mỗi class = 1 bảng trong database. JPA tự động map giữa Java object và SQL.

```java
@Entity                     // "Đây là JPA entity, map với 1 bảng trong DB"
@Table(name = "products")   // Tên bảng trong DB là "products"
public class Product extends BaseEntity {   // Kế thừa created_at, updated_at

    @Id                                              // Đây là primary key
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto increment
    private Long id;

    @Column(name = "name", nullable = false, length = 350)  // Map với cột "name"
    private String name;

    private Float price;     // Nếu không có @Column, tên cột = tên field

    @ManyToOne               // Quan hệ Nhiều-Một (nhiều Product thuộc 1 Category)
    @JoinColumn(name = "category_id")   // Tên cột FK trong bảng products
    private Category category;
}
```

**Các annotation quan hệ:**
| Annotation   | Ý nghĩa                       | Ví dụ                         |
|-------------|--------------------------------|-------------------------------|
| `@ManyToOne`  | Nhiều -> Một                 | Product -> Category           |
| `@OneToMany`  | Một -> Nhiều                 | Category -> List\<Product\>   |
| `@JoinColumn` | Chỉ định cột foreign key    | `category_id` trong products  |
| `@MappedSuperclass` | Class cha (không tạo bảng) | BaseEntity (timestamps) |

**BaseEntity - Class cha chung:**
```java
@MappedSuperclass   // Không tạo bảng riêng, chỉ để kế thừa
public class BaseEntity {
    @Column(name = "created_at")
    @CreationTimestamp   // Hibernate tự set khi INSERT
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    @UpdateTimestamp     // Hibernate tự set khi UPDATE
    private LocalDateTime updatedAt;
}
```

Tất cả entity kế thừa BaseEntity sẽ tự động có `created_at` và `updated_at`.

### 5.2 Repository - Truy vấn Database

Spring Data JPA tự động tạo SQL từ tên method. Bạn chỉ cần định nghĩa interface.

```java
public interface ProductRepository extends JpaRepository<Product, Long> {

    // Spring tự động tạo: SELECT * FROM products WHERE name = ?
    boolean existsByName(String name);

    // Custom query với @Query
    @Query("SELECT p FROM Product p WHERE p.name LIKE %:keyword%")
    Page<Product> searchProducts(@Param("keyword") String keyword, Pageable pageable);
}
```

**Các method có sẵn từ JpaRepository:**
| Method               | SQL tương đương                        |
|---------------------|----------------------------------------|
| `findById(id)`      | `SELECT * FROM products WHERE id = ?`  |
| `findAll()`         | `SELECT * FROM products`               |
| `save(entity)`      | `INSERT` hoặc `UPDATE` (tự động)      |
| `deleteById(id)`    | `DELETE FROM products WHERE id = ?`    |
| `count()`           | `SELECT COUNT(*) FROM products`        |
| `existsById(id)`    | `SELECT EXISTS(...)`                   |

**Quy tắc đặt tên method:**
| Tên method                     | SQL                                    |
|-------------------------------|----------------------------------------|
| `findByName(name)`            | `WHERE name = ?`                       |
| `findByPriceGreaterThan(p)`   | `WHERE price > ?`                      |
| `findByNameContaining(kw)`    | `WHERE name LIKE %kw%`                 |
| `findByUserId(userId)`        | `WHERE user_id = ?`                    |
| `existsByPhoneNumber(phone)`  | `SELECT EXISTS(... WHERE phone_number = ?)` |

### 5.3 DTO - Dữ liệu từ Client gửi lên

DTO (Data Transfer Object) chỉ chứa những field cần thiết từ client, KHÔNG phải toàn bộ entity.

```java
@Data
@Builder
public class ProductDTO {

    @NotBlank(message = "Title is required")    // Không được rỗng
    @Size(min = 3, max = 200)                   // Độ dài 3-200 ký tự
    private String name;

    @Min(value = 0)                              // Giá >= 0
    @Max(value = 10000000)                       // Giá <= 10 triệu
    private Float price;

    private String description;
    private String thumbnail;

    @JsonProperty("category_id")    // JSON: "category_id" -> Java: "categoryId"
    private Long categoryId;
}
```

**Tại sao cần DTO thay vì dùng trực tiếp Entity?**
- Entity có nhiều field nội bộ (id, timestamps) - client không cần gửi
- DTO có validation (@NotBlank, @Min) - Entity không nên có
- Bảo mật: tránh client gửi những field nhạy cảm (role, password hash)

**Luồng dữ liệu:**
```
Client gửi JSON  -->  DTO (validate)  -->  Service (convert)  -->  Entity (lưu DB)
                                                                        |
Client nhận JSON <--  Response DTO    <--  Service (convert)  <--  Entity (đọc DB)
```

### 5.4 Service - Xử lý Business Logic

```java
// Interface: định nghĩa "làm gì"
public interface IProductService {
    Product createProduct(ProductDTO productDTO) throws DataNotFoundException;
    Product getProductById(long id) throws DataNotFoundException;
    Page<ProductResponse> getAllProducts(PageRequest pageRequest);
    Product updateProduct(long id, ProductDTO productDTO) throws DataNotFoundException;
    void deleteProduct(long id);
}

// Implementation: định nghĩa "làm như thế nào"
@Service                    // Đánh dấu là Spring Bean (Service layer)
@RequiredArgsConstructor    // Tự tạo constructor inject các field final
public class ProductService implements IProductService {

    private final ProductRepository productRepository;       // Inject repository
    private final CategoryRepository categoryRepository;

    @Override
    public Product createProduct(ProductDTO productDTO) throws DataNotFoundException {
        // 1. Kiểm tra category có tồn tại?
        Category existingCategory = categoryRepository
            .findById(productDTO.getCategoryId())
            .orElseThrow(() -> new DataNotFoundException(
                "Can't find category with id: " + productDTO.getCategoryId()));

        // 2. Convert DTO -> Entity bằng Builder pattern
        Product newProduct = Product.builder()
            .name(productDTO.getName())
            .price(productDTO.getPrice())
            .thumbnail(productDTO.getThumbnail())
            .description(productDTO.getDescription())
            .category(existingCategory)
            .build();

        // 3. Lưu vào DB và trả về
        return productRepository.save(newProduct);
    }
}
```

### 5.5 Controller - Nhận HTTP Request

```java
@RestController                           // Trả về JSON (không phải HTML)
@RequestMapping("${api.prefix}/products") // Base URL: /api/v1/products
@RequiredArgsConstructor
public class ProductController {

    private final IProductService productService;  // Inject interface

    // GET /api/v1/products?page=0&limit=10
    @GetMapping("")
    public ResponseEntity<ProductListResponse> getProducts(
            @RequestParam("page") int page,         // ?page=0
            @RequestParam("limit") int limit) {     // &limit=10
        // ...
    }

    // POST /api/v1/products  (body: JSON)
    @PostMapping("")
    public ResponseEntity<?> createProduct(
            @Valid @RequestBody ProductDTO productDTO,   // Parse JSON body + validate
            BindingResult result) {                       // Chứa kết quả validation

        // Kiểm tra lỗi validation
        if (result.hasErrors()) {
            List<String> errorMessages = result.getFieldErrors()
                .stream()
                .map(FieldError::getDefaultMessage)
                .toList();
            return ResponseEntity.badRequest().body(errorMessages);
        }

        try {
            Product newProduct = productService.createProduct(productDTO);
            return ResponseEntity.ok(newProduct);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // GET /api/v1/products/123
    @GetMapping("/{id}")
    public ResponseEntity<?> getProductById(@PathVariable("id") Long productId) {
        // @PathVariable lấy giá trị từ URL: /products/{id}
    }

    // PUT /api/v1/products/123
    @PutMapping("/{id}")
    public ResponseEntity<?> updateProduct(@PathVariable long id, ...) { }

    // DELETE /api/v1/products/123
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteProduct(@PathVariable long id) { }
}
```

**Các annotation quan trọng:**
| Annotation       | Tác dụng                                    |
|-----------------|---------------------------------------------|
| `@RestController`| Tất cả method trả về JSON                  |
| `@RequestMapping`| Base URL cho controller                     |
| `@GetMapping`    | Xử lý GET request                          |
| `@PostMapping`   | Xử lý POST request                         |
| `@PutMapping`    | Xử lý PUT request                          |
| `@DeleteMapping` | Xử lý DELETE request                       |
| `@RequestParam`  | Lấy giá trị từ query string (?key=value)   |
| `@PathVariable`  | Lấy giá trị từ URL (/products/{id})        |
| `@RequestBody`   | Parse JSON body thành Java object          |
| `@Valid`         | Kích hoạt validation trên DTO              |
| `BindingResult`  | Chứa danh sách lỗi validation             |

### 5.6 Response DTO - Dữ liệu trả về Client

```java
@Data
@Builder
public class ProductResponse extends BaseResponse {  // Kế thừa created_at, updated_at

    private String name;
    private Float price;
    private String thumbnail;
    private String description;

    @JsonProperty("category_id")
    private Long categoryId;

    // Static method convert Entity -> Response
    public static ProductResponse fromProduct(Product product) {
        ProductResponse productResponse = ProductResponse.builder()
            .name(product.getName())
            .price(product.getPrice())
            .thumbnail(product.getThumbnail())
            .description(product.getDescription())
            .categoryId(product.getCategory() != null
                ? product.getCategory().getId() : null)
            .build();
        productResponse.setCreatedAt(product.getCreatedAt());
        productResponse.setUpdatedAt(product.getUpdatedAt());
        return productResponse;
    }
}
```

---

## 6. Security - JWT Authentication

### 6.1 JWT là gì?

JWT (JSON Web Token) là một chuỗi mã hóa chứa thông tin người dùng:

```
eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjA5MDkuLi4iLCJzdWIiOiIwOTA5Li4uIiwiZXhwIjoxNzE...
|___ Header ___|.___________ Payload ___________|._______ Signature _______|
```

- **Header**: Thuật toán mã hóa (HS256)
- **Payload**: Dữ liệu (phone number, thời gian hết hạn)
- **Signature**: Chữ ký (đảm bảo token không bị sửa đổi)

### 6.2 Luồng Đăng Nhập

```
Bước 1: Client gửi phone + password
        POST /api/v1/users/login
        {"phone_number": "0123456789", "password": "123456"}
                    |
                    v
Bước 2: Server kiểm tra
        - Tìm user theo phone number
        - So sánh password (BCrypt)
        - Nếu đúng -> Tạo JWT token
                    |
                    v
Bước 3: Server trả về token
        {"message": "Login successfully", "token": "eyJhbG..."}
                    |
                    v
Bước 4: Client lưu token (localStorage/cookie)
        Mỗi request sau gửi kèm header:
        Authorization: Bearer eyJhbG...
```

### 6.3 JWT Token được tạo như thế nào?

```java
// JwtTokenUtil.java
public String generateToken(User user) throws InvalidParamsException {
    Map<String, Object> claims = new HashMap<>();
    claims.put("phoneNumber", user.getPhoneNumber());

    String token = Jwts.builder()
        .claims(claims)                             // Dữ liệu trong token
        .subject(user.getPhoneNumber())             // Chủ thể = phone number
        .expiration(new Date(now + 30_ngày))        // Hết hạn sau 30 ngày
        .signWith(getSigninKey(), Jwts.SIG.HS256)   // Ký bằng secret key
        .compact();                                  // -> chuỗi JWT
    return token;
}
```

### 6.4 Mỗi request được kiểm tra như thế nào?

```java
// JwtTokenFilter.java - Chạy TRƯỚC mỗi request
public class JwtTokenFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(request, response, filterChain) {

        // 1. Bypass những API công khai (login, register, xem sản phẩm...)
        if (isBypassToken(request)) {
            filterChain.doFilter(request, response);
            return;
        }

        // 2. Lấy token từ header "Authorization: Bearer xxx..."
        String authHeader = request.getHeader("Authorization");
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            response.sendError(401, "Unauthorized");
            return;
        }
        String token = authHeader.substring(7);  // Cắt bỏ "Bearer "

        // 3. Giải mã token -> lấy phone number
        String phoneNumber = jwtTokenUtil.extractPhoneNumber(token);

        // 4. Load user từ DB
        User userDetails = userDetailsService.loadUserByUsername(phoneNumber);

        // 5. Kiểm tra token còn hợp lệ?
        if (jwtTokenUtil.validateToken(token, userDetails)) {
            // 6. Set user vào SecurityContext -> Spring biết ai đang request
            SecurityContextHolder.getContext().setAuthentication(...);
        }

        // 7. Cho request đi tiếp
        filterChain.doFilter(request, response);
    }
}
```

### 6.5 Phân quyền (Authorization)

```java
// WebSecurityConfig.java
http.authorizeHttpRequests(request -> {
    // PUBLIC - ai cũng truy cập được
    request.requestMatchers("/api/v1/users/register", "/api/v1/users/login").permitAll()
    .requestMatchers(GET, "/api/v1/products/**").permitAll()
    .requestMatchers(GET, "/api/v1/categories/**").permitAll()
    .requestMatchers(GET, "/api/v1/roles**").permitAll()

    // CHỈ ADMIN
    .requestMatchers(POST, "/api/v1/products/**").hasRole("ADMIN")
    .requestMatchers(PUT, "/api/v1/products/**").hasRole("ADMIN")
    .requestMatchers(DELETE, "/api/v1/products/**").hasRole("ADMIN")

    // CHỈ USER
    .requestMatchers(POST, "/api/v1/orders/**").hasRole("USER")

    // USER hoặc ADMIN
    .requestMatchers(GET, "/api/v1/orders/**").hasAnyRole("USER", "ADMIN")

    // Tất cả request khác phải đăng nhập
    .anyRequest().authenticated();
});
```

### 6.6 Password được mã hóa như thế nào?

```java
// Khi đăng ký: mã hóa password trước khi lưu DB
String encodePassword = passwordEncoder.encode("123456");
// -> "$2a$10$YClzZfm/mSwnT05aLuoxYOS7xGV0BqPTPVjNRmvdvUweiEqEyImqa"

// Khi đăng nhập: so sánh password
passwordEncoder.matches("123456", encodePassword);  // true
passwordEncoder.matches("wrong", encodePassword);   // false
```

BCrypt là one-way hash -> KHÔNG thể giải mã ngược lại.

---

## 7. Luồng Xử Lý Một Request

### Ví dụ: Tạo sản phẩm mới

```
POST /api/v1/products
Header: Authorization: Bearer eyJhbG...
Body: {"name": "iPhone 15", "price": 25000000, "category_id": 1}
```

```
1. JwtTokenFilter.doFilterInternal()
   |-- Lấy token từ header
   |-- Giải mã -> phone = "0123456789"
   |-- Load user từ DB -> role = ADMIN
   |-- Set vào SecurityContext
   |-- Cho request đi tiếp

2. WebSecurityConfig
   |-- POST /api/v1/products/** -> hasRole(ADMIN)
   |-- User có role ADMIN -> OK, cho phép

3. ProductController.createProduct()
   |-- @Valid: Kiểm tra ProductDTO
   |     |-- name != blank? OK
   |     |-- price >= 0? OK
   |     |-- category_id != null? OK
   |-- BindingResult: không có lỗi
   |-- Gọi productService.createProduct(productDTO)

4. ProductService.createProduct()
   |-- categoryRepository.findById(1)
   |     |-- Tìm thấy Category "Điện thoại" -> OK
   |-- Product.builder()
   |     .name("iPhone 15")
   |     .price(25000000)
   |     .category(category)
   |     .build()
   |-- productRepository.save(newProduct)
   |     |-- JPA tạo SQL: INSERT INTO products (name, price, ...) VALUES (...)
   |     |-- Trả về Product với id được generate

5. Controller trả về:
   ResponseEntity.ok(newProduct)  ->  HTTP 200 + JSON body
```

### Ví dụ: Đăng nhập

```
POST /api/v1/users/login
Body: {"phone_number": "0123456789", "password": "123456"}
```

```
1. JwtTokenFilter
   |-- isBypassToken() -> "/users/login" + POST -> BYPASS (không cần token)

2. UserController.login()
   |-- Gọi userService.login(phone, password)

3. UserService.login()
   |-- userRepository.findByPhoneNumber("0123456789")
   |     |-- Tìm thấy user -> OK
   |-- passwordEncoder.matches("123456", hash) -> OK
   |-- authenticationManager.authenticate(...) -> OK
   |-- jwtTokenUtil.generateToken(user)
   |     |-- Tạo JWT với phone, expiration 30 ngày
   |     |-- Trả về "eyJhbG..."

4. Controller trả về:
   {"message": "Login successfully", "token": "eyJhbG..."}
```

---

## 8. Danh Sách API

### Users
| Method | Endpoint             | Auth   | Mô tả                   |
|--------|---------------------|--------|--------------------------|
| POST   | `/users/register`   | Public | Đăng ký tài khoản       |
| POST   | `/users/login`      | Public | Đăng nhập -> nhận JWT   |

### Categories
| Method | Endpoint             | Auth   | Mô tả                   |
|--------|---------------------|--------|--------------------------|
| GET    | `/categories`       | Public | Danh sách danh mục      |
| POST   | `/categories`       | ADMIN  | Tạo danh mục            |
| PUT    | `/categories/{id}`  | ADMIN  | Cập nhật danh mục       |
| DELETE | `/categories/{id}`  | ADMIN  | Xóa danh mục            |

### Products
| Method | Endpoint               | Auth   | Mô tả                   |
|--------|------------------------|--------|--------------------------|
| GET    | `/products?page=&limit=`| Public | Danh sách SP (phân trang)|
| GET    | `/products/{id}`       | Public | Chi tiết sản phẩm       |
| GET    | `/products/images/{name}`| Public| Lấy ảnh sản phẩm       |
| POST   | `/products`            | ADMIN  | Tạo sản phẩm            |
| POST   | `/products/uploads/{id}`| ADMIN | Upload ảnh sản phẩm     |
| PUT    | `/products/{id}`       | ADMIN  | Cập nhật sản phẩm       |
| DELETE | `/products/{id}`       | ADMIN  | Xóa sản phẩm            |

### Orders
| Method | Endpoint             | Auth       | Mô tả                   |
|--------|---------------------|------------|--------------------------|
| POST   | `/orders`           | USER       | Đặt hàng                |
| GET    | `/orders/{user_id}` | USER/ADMIN | Xem đơn hàng của user   |
| PUT    | `/orders/{id}`      | ADMIN      | Cập nhật đơn hàng       |
| DELETE | `/orders/{id}`      | ADMIN      | Xóa mềm đơn hàng       |

### Order Details
| Method | Endpoint                  | Auth       | Mô tả                   |
|--------|--------------------------|------------|--------------------------|
| POST   | `/order_details`         | USER       | Tạo chi tiết đơn hàng   |
| GET    | `/order_details/{id}`    | USER/ADMIN | Xem chi tiết            |
| GET    | `/order_details/order/{id}`| USER/ADMIN| Xem theo đơn hàng      |
| PUT    | `/order_details/{id}`    | ADMIN      | Cập nhật chi tiết       |
| DELETE | `/order_details/{id}`    | ADMIN      | Xóa chi tiết            |

### Roles
| Method | Endpoint   | Auth   | Mô tả              |
|--------|-----------|--------|---------------------|
| GET    | `/roles`  | Public | Danh sách vai trò   |

> Tất cả endpoint có prefix: `/api/v1/`
> Ví dụ đầy đủ: `http://localhost:8088/api/v1/products`

---

## 9. Cấu Trúc Thư Mục

```
src/main/java/com/project/shopapp/
|
|-- components/              # Các utility component
|   |-- JwtTokenUtil.java        # Tạo và verify JWT token
|   |-- LocalizationUtils.java   # Đa ngôn ngữ (i18n)
|
|-- configurations/          # Cấu hình Spring
|   |-- MapperConfiguration.java     # Bean ModelMapper, ObjectMapper
|   |-- SecurityConfig.java          # Bean PasswordEncoder, AuthenticationManager
|   |-- WebSecurityConfig.java       # Phân quyền API (ai được truy cập gì)
|   |-- LanguageConfig.java          # Cấu hình đa ngôn ngữ
|
|-- controllers/             # REST API endpoints
|   |-- UserController.java      # /users/register, /users/login
|   |-- ProductController.java   # CRUD products, upload images
|   |-- CategoryController.java  # CRUD categories
|   |-- OrderController.java     # CRUD orders
|   |-- OrderDetailController.java  # CRUD order details
|   |-- RoleController.java      # GET roles
|   |-- HealthCheckController.java  # Health check endpoint
|
|-- dtos/                    # Request DTOs (dữ liệu client gửi lên)
|   |-- UserDTO.java             # Đăng ký
|   |-- UserLoginDTO.java        # Đăng nhập
|   |-- ProductDTO.java          # Tạo/sửa sản phẩm
|   |-- ProductImageDTO.java     # Upload ảnh
|   |-- CategoryDTO.java         # Tạo/sửa danh mục
|   |-- OrderDTO.java            # Đặt hàng
|   |-- OrderDetailDTO.java      # Chi tiết đơn hàng
|
|-- exceptions/              # Custom exceptions
|   |-- DataNotFoundException.java      # Không tìm thấy dữ liệu
|   |-- InvalidParamsException.java     # Tham số không hợp lệ
|   |-- PermissionDenyException.java    # Không có quyền
|
|-- filters/                 # HTTP filters
|   |-- JwtTokenFilter.java     # Kiểm tra JWT token mỗi request
|
|-- models/                  # JPA Entities (ánh xạ bảng DB)
|   |-- BaseEntity.java         # Class cha: created_at, updated_at
|   |-- User.java               # Bảng users (implements UserDetails)
|   |-- Product.java            # Bảng products
|   |-- ProductImage.java       # Bảng product_images
|   |-- Category.java           # Bảng categories
|   |-- Order.java              # Bảng orders
|   |-- OrderDetail.java        # Bảng order_details
|   |-- Role.java               # Bảng roles
|   |-- SocialAccount.java      # Bảng social_accounts
|   |-- OrderStatus.java        # Enum trạng thái đơn hàng
|
|-- repository/              # Spring Data JPA repositories
|   |-- UserRepository.java
|   |-- ProductRepository.java
|   |-- ProductImageRepository.java
|   |-- CategoryRepository.java
|   |-- OrderRepository.java
|   |-- OrderDetailRepository.java
|   |-- RoleRepository.java
|
|-- response/                # Response DTOs (dữ liệu trả về client)
|   |-- BaseResponse.java           # Class cha: created_at, updated_at
|   |-- LoginResponse.java          # {message, token}
|   |-- RegisterResponse.java
|   |-- ProductResponse.java        # Sản phẩm (có category_id)
|   |-- ProductListResponse.java    # {products[], totalPages}
|   |-- CategoryResponse.java
|   |-- UpdateCategoryResponse.java
|   |-- OrderResponse.java
|   |-- OrderDetailResponse.java
|   |-- OrderListResponse.java
|
|-- services/                # Business logic
|   |-- IUserService.java           # Interface
|   |-- UserService.java            # Implementation
|   |-- IProductService.java
|   |-- ProductService.java
|   |-- ICategoryService.java
|   |-- CategoryService.java
|   |-- IOrderService.java
|   |-- OrderService.java
|   |-- IOrderDetailService.java
|   |-- OrderDetailService.java
|   |-- IRoleService.java
|   |-- RoleService.java
|
|-- utils/                   # Constants & Utilities
|   |-- MessageKeys.java         # Hằng số key đa ngôn ngữ
|   |-- WebUtils.java
|
src/main/resources/
|-- application.yml              # Config MySQL (dev)
|-- application-render.yml       # Config PostgreSQL (production)
|-- data.sql                     # Seed data (roles, categories, admin)
|-- i18n/
|   |-- messages_en.properties   # Tiếng Anh
|   |-- messages_vi.properties   # Tiếng Việt
```

---

## Tổng Kết Nhanh

| Khái niệm        | File/Folder      | Vai trò                              |
|-------------------|-----------------|--------------------------------------|
| Entity (Model)    | `models/`       | Ánh xạ bảng DB                      |
| Repository        | `repository/`   | Truy vấn DB (tự động tạo SQL)       |
| Service           | `services/`     | Xử lý logic nghiệp vụ              |
| Controller        | `controllers/`  | Nhận/trả HTTP request               |
| DTO               | `dtos/`         | Dữ liệu từ client (có validation)   |
| Response          | `response/`     | Dữ liệu trả về client              |
| Filter            | `filters/`      | Kiểm tra JWT trước mỗi request     |
| Security Config   | `configurations/`| Phân quyền API                     |
| Exception         | `exceptions/`   | Lỗi cụ thể (không dùng Exception chung) |
