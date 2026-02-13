# Java Core - Ôn Lại Từ Gốc

> Những khái niệm Java mà dự án ShopApp dùng nhiều, giải thích từ cơ bản nhất.

---

## Mục Lục

1. [Collections - List, Map](#1-collections---list-map)
2. [Generics - Kiểu trong dấu <>](#2-generics---kiểu-trong-dấu-)
3. [Lambda -> và Method Reference ::](#3-lambda---và-method-reference-)
4. [Optional - Cái hộp chống null](#4-optional---cái-hộp-chống-null)
5. [Stream API - Xử lý list kiểu chuỗi](#5-stream-api---xử-lý-list-kiểu-chuỗi)
6. [Exceptions - Xử lý lỗi](#6-exceptions---xử-lý-lỗi)
7. [Annotations - Dấu @](#7-annotations---dấu-)

---

## 1. Collections - List, Map

### List - Danh sách có thứ tự

```java
// Tạo list
List<String> names = new ArrayList<>();
names.add("iPhone");
names.add("Samsung");
names.add("Xiaomi");

// Lấy phần tử
names.get(0);  // "iPhone"
names.size();  // 3

// Duyệt
for (String name : names) {
    System.out.println(name);
}
```

Trong dự án, List xuất hiện khắp nơi:

```java
// OrderService - lấy danh sách đơn hàng của 1 user
List<Order> orders = orderRepository.findByUserId(userId);

// Controller - lấy danh sách lỗi validation
List<String> errorMessages = result.getFieldErrors()
    .stream()
    .map(FieldError::getDefaultMessage)
    .toList();
```

### Map - Cặp key-value

```java
// Tạo map
Map<String, Object> claims = new HashMap<>();
claims.put("phoneNumber", "0909090909");
claims.put("role", "ADMIN");

// Lấy giá trị
claims.get("phoneNumber");  // "0909090909"
```

Trong dự án, Map dùng khi tạo JWT token:

```java
// JwtTokenUtil.java
Map<String, Object> claims = new HashMap<>();
claims.put("phoneNumber", user.getPhoneNumber());
// claims = {"phoneNumber": "0909090909"} -> nhét vào token
```

---

## 2. Generics - Kiểu trong dấu `<>`

Khi bạn thấy `<>`, đó là Generics - nói cho Java biết **kiểu dữ liệu cụ thể**.

```java
// Không có Generics - nguy hiểm
List list = new ArrayList();
list.add("text");
list.add(123);        // Cho thêm số vào cùng list -> loạn
String s = (String) list.get(1);  // CRASH! Vì phần tử 1 là số

// Có Generics - an toàn
List<String> list = new ArrayList<>();
list.add("text");
list.add(123);        // LỖI COMPILE! Chỉ nhận String
```

Trong dự án:

```java
List<Order> orders;              // List chỉ chứa Order
Optional<User> optionalUser;     // Hộp chỉ chứa User
JpaRepository<Product, Long>     // Repository cho Product, id kiểu Long
ResponseEntity<String>           // Response chứa String
```

**`<?>`** = wildcard = "bất kỳ kiểu gì":

```java
// Controller trả về ResponseEntity<?>
// Vì có lúc trả Product, có lúc trả String (lỗi)
public ResponseEntity<?> createProduct(...) {
    // Thành công -> trả Product
    return ResponseEntity.ok(newProduct);
    // Lỗi -> trả String
    return ResponseEntity.badRequest().body("Lỗi rồi");
}
```

---

## 3. Lambda `->` và Method Reference `::`

### Lambda: hàm ẩn danh (không tên)

```java
// Cách cũ: viết cả class
Runnable r = new Runnable() {
    @Override
    public void run() {
        System.out.println("Hello");
    }
};

// Lambda: viết 1 dòng
Runnable r = () -> System.out.println("Hello");
```

Cú pháp: `(tham số) -> { thân hàm }`

```java
// Không tham số
() -> System.out.println("Hello")

// 1 tham số (bỏ ngoặc được)
name -> System.out.println(name)

// 2 tham số
(a, b) -> a + b

// Nhiều dòng thì dùng {}
(a, b) -> {
    int sum = a + b;
    return sum;
}
```

Trong dự án, lambda dùng nhiều nhất với `orElseThrow`:

```java
// () -> new DataNotFoundException(...)  là 1 lambda
// Nghĩa: "nếu không tìm thấy, thì chạy hàm này để tạo exception"
User user = userRepository.findById(id)
    .orElseThrow(() -> new DataNotFoundException("User not found"));
//               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//               Lambda: không có tham số, trả về 1 exception
```

### Method Reference `::` - viết gọn hơn lambda

```java
// Lambda
.map(error -> error.getDefaultMessage())

// Method Reference (giống hệt, nhưng gọn hơn)
.map(FieldError::getDefaultMessage)

// Đọc là: "gọi method getDefaultMessage của FieldError"
```

Chỉ dùng `::` khi lambda đơn giản kiểu `x -> x.method()`.

---

## 4. Optional - Cái hộp chống null

**Vấn đề:** Khi query DB, có thể không tìm thấy gì -> trả `null` -> gọi method trên null -> **CRASH**.

```java
User user = findById(999);  // không có user 999 -> null
user.getName();             // NullPointerException!
```

**Giải pháp:** `Optional` = cái hộp, có thể chứa hoặc rỗng.

```java
Optional<User> box = userRepository.findById(999);

// Kiểm tra hộp có rỗng không
box.isPresent();  // false (không tìm thấy)
box.isEmpty();    // true

// Lấy giá trị ra (nếu có)
box.get();  // NGUY HIỂM! Nếu rỗng sẽ crash
```

**Cách dùng an toàn** (dự án dùng cách này):

```java
// Cách 1: orElseThrow - không có thì ném lỗi (DÙNG NHIỀU NHẤT)
User user = userRepository.findById(id)
    .orElseThrow(() -> new DataNotFoundException("User not found"));
// Tìm thấy -> trả user
// Không thấy -> ném DataNotFoundException

// Cách 2: orElse - không có thì trả giá trị mặc định
Order order = orderRepository.findById(id).orElse(null);
// Tìm thấy -> trả order
// Không thấy -> trả null
```

---

## 5. Stream API - Xử lý list kiểu chuỗi

Stream = cách xử lý danh sách theo từng bước, nối tiếp nhau.

### Hình dung:

```
[lỗi1, lỗi2, lỗi3]     // List gốc
        |
    .stream()            // Bắt đầu xử lý
        |
    .map(lấy message)   // Biến đổi: lỗi -> message
        |
[msg1, msg2, msg3]
        |
    .toList()            // Thu thập lại thành List
```

### Ví dụ trong dự án:

```java
// Lấy danh sách message lỗi từ validation
List<String> errorMessages = result.getFieldErrors()  // [FieldError1, FieldError2, ...]
    .stream()                              // bắt đầu stream
    .map(FieldError::getDefaultMessage)    // biến mỗi FieldError -> String message
    .toList();                             // thu thập thành List<String>
```

Tương đương vòng for:

```java
List<String> errorMessages = new ArrayList<>();
for (FieldError error : result.getFieldErrors()) {
    errorMessages.add(error.getDefaultMessage());
}
```

### Các method Stream hay dùng:

```java
List<Integer> numbers = List.of(1, 2, 3, 4, 5);

// .map() - biến đổi từng phần tử
numbers.stream().map(n -> n * 2).toList();
// [2, 4, 6, 8, 10]

// .filter() - lọc
numbers.stream().filter(n -> n > 3).toList();
// [4, 5]

// .forEach() - làm gì đó với từng phần tử
numbers.stream().forEach(n -> System.out.println(n));
```

---

## 6. Exceptions - Xử lý lỗi

### try-catch: bắt lỗi

```java
try {
    // Code có thể gây lỗi
    Product product = productService.createProduct(dto);
    return ResponseEntity.ok(product);
} catch (DataNotFoundException e) {
    // Nếu lỗi DataNotFound -> trả 400
    return ResponseEntity.badRequest().body(e.getMessage());
} catch (Exception e) {
    // Bắt mọi lỗi khác
    return ResponseEntity.badRequest().body("Lỗi không xác định");
}
```

### throws: "tôi không xử lý, để người gọi xử lý"

```java
// Service khai báo "method này CÓ THỂ ném lỗi"
public Product createProduct(ProductDTO dto) throws DataNotFoundException {
    Category cat = categoryRepository.findById(dto.getCategoryId())
        .orElseThrow(() -> new DataNotFoundException("Category not found"));
    //  ^^ ném lỗi ở đây, nhưng không catch -> ném lên cho Controller
}

// Controller phải catch lỗi từ Service
try {
    Product p = productService.createProduct(dto);  // có thể ném DataNotFoundException
} catch (DataNotFoundException e) {
    // Controller bắt và trả về response lỗi cho client
    return ResponseEntity.badRequest().body(e.getMessage());
}
```

### Luồng exception trong dự án:

```
Repository: findById(999) -> Optional rỗng
    |
Service: .orElseThrow(() -> new DataNotFoundException("..."))
    |     ^^ ném lỗi, khai báo throws, KHÔNG catch
    |
Controller: try { service.method() } catch (Exception e) { ... }
    |       ^^ catch lỗi, trả về ResponseEntity.badRequest()
    |
Client nhận: HTTP 400 + {"message": "Can't find user with id: 999"}
```

### Custom Exception trong dự án:

```java
// Tự tạo exception riêng, kế thừa Exception
public class DataNotFoundException extends Exception {
    public DataNotFoundException(String message) {
        super(message);
    }
}

// Sử dụng:
throw new DataNotFoundException("Can't find user with id: " + id);
```

Dự án có 3 custom exception:

| Exception                | Khi nào dùng                    |
|--------------------------|--------------------------------|
| `DataNotFoundException`  | Không tìm thấy dữ liệu trong DB |
| `InvalidParamsException` | Tham số không hợp lệ           |
| `PermissionDenyException`| Không có quyền (VD: user tạo account admin) |

---

## 7. Annotations - Dấu `@`

Annotation = "nhãn dán" lên class/method/field, nói cho framework biết phải làm gì.

### JPA (Database):

| Annotation     | Ý nghĩa                                |
|---------------|----------------------------------------|
| `@Entity`     | "Class này là 1 bảng DB"              |
| `@Table`      | "Tên bảng là..."                       |
| `@Id`         | "Field này là primary key"             |
| `@GeneratedValue` | "DB tự tăng id"                   |
| `@Column`     | "Field này map với cột..."             |
| `@ManyToOne`  | "Quan hệ nhiều-một"                   |
| `@JoinColumn` | "Tên cột foreign key"                 |
| `@MappedSuperclass` | "Class cha, không tạo bảng riêng" |

### Spring:

| Annotation       | Ý nghĩa                                    |
|-----------------|---------------------------------------------|
| `@Service`       | "Class này là Service, Spring quản lý"     |
| `@RestController`| "Class này nhận HTTP request, trả JSON"    |
| `@Component`     | "Class này là Bean, Spring quản lý"        |
| `@Configuration` | "Class này chứa cấu hình"                 |
| `@Bean`          | "Method này trả về object, Spring quản lý" |
| `@Value`         | "Lấy giá trị từ file config (application.yml)" |

### Spring Web:

| Annotation       | Ý nghĩa                                    |
|-----------------|---------------------------------------------|
| `@RequestMapping`| Base URL cho controller                     |
| `@GetMapping`    | Xử lý GET request                          |
| `@PostMapping`   | Xử lý POST request                         |
| `@PutMapping`    | Xử lý PUT request                          |
| `@DeleteMapping` | Xử lý DELETE request                       |
| `@RequestParam`  | Lấy giá trị từ query string `?key=value`   |
| `@PathVariable`  | Lấy giá trị từ URL `/products/{id}`        |
| `@RequestBody`   | Parse JSON body thành Java object          |
| `@Valid`         | Kích hoạt validation trên DTO              |

### Lombok:

| Annotation              | Ý nghĩa                                  |
|-------------------------|------------------------------------------|
| `@Data`                 | Getter + Setter + toString + equals + hashCode |
| `@Builder`              | Builder pattern: `.name("X").build()`    |
| `@NoArgsConstructor`    | Constructor rỗng                          |
| `@AllArgsConstructor`   | Constructor với tất cả field             |
| `@RequiredArgsConstructor`| Constructor cho các field `final` (dùng cho DI) |

### Validation:

| Annotation  | Ý nghĩa                       |
|------------|-------------------------------|
| `@NotBlank`| Không được rỗng hoặc toàn space |
| `@Size`    | Giới hạn độ dài               |
| `@Min`     | Giá trị tối thiểu             |
| `@Max`     | Giá trị tối đa               |

Không cần nhớ hết, gặp annotation lạ thì tra - nhưng những cái trên là dùng nhiều nhất trong dự án.
