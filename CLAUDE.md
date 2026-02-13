# ShopApp - Spring Boot Backend

## Project Overview
E-commerce REST API backend built with Spring Boot 3.3.3 and Java 17.
This is a learning project for practicing fullstack Java (Angular/React + Spring Boot).

## Tech Stack
- **Framework**: Spring Boot 3.3.3, Spring Security, Spring Data JPA
- **Java**: 17
- **Build**: Maven (`./mvnw` wrapper available)
- **Database**: MySQL 8.0 (dev, port 3307) / PostgreSQL (prod profile `render`)
- **Auth**: JWT (jjwt 0.12.6) with BCrypt password encoding
- **Libraries**: Lombok 1.18.42, ModelMapper 3.2.1, JavaFaker 1.0.2

## Quick Commands
```bash
# Run locally (requires MySQL on port 3307)
./mvnw spring-boot:run

# Run with PostgreSQL profile
./mvnw spring-boot:run -Dspring-boot.run.profiles=render

# Build
./mvnw clean package -DskipTests

# Run tests
./mvnw test

# Docker
docker-compose up -d
```

## Project Structure
```
src/main/java/com/project/shopapp/
├── components/        # JwtTokenUtil, LocalizationUtils
├── configurations/    # Security, CORS, ModelMapper, i18n configs
├── controllers/       # REST controllers (API endpoints)
├── dtos/              # Request DTOs with validation annotations
├── exceptions/        # DataNotFoundException, InvalidParamsException, PermissionDenyException
├── filters/           # JwtTokenFilter (OncePerRequestFilter)
├── models/            # JPA entities (BaseEntity provides timestamps)
├── repository/        # Spring Data JPA repositories
├── response/          # Response DTOs (BaseResponse provides timestamps)
├── services/          # Business logic (Interface + Implementation pattern)
└── utils/             # MessageKeys constants, WebUtils
```

## Architecture & Conventions

### Layered Architecture
Controller -> Service (interface) -> Repository -> Database

### Naming Conventions
- **Entities**: PascalCase (`Product`, `OrderDetail`), table names snake_case (`order_details`)
- **DTOs**: suffix `DTO` (`ProductDTO`), JSON fields use `@JsonProperty("snake_case")`
- **Responses**: suffix `Response` (`ProductResponse`), extend `BaseResponse`
- **Services**: interface `I*Service` + implementation `*Service`
- **Repositories**: suffix `Repository`

### Key Patterns
- **Lombok everywhere**: `@Data`, `@Builder`, `@NoArgsConstructor`, `@AllArgsConstructor`, `@RequiredArgsConstructor`
- **Constructor injection**: via `@RequiredArgsConstructor` (no `@Autowired` on fields)
- **DI via interfaces**: Controllers inject `I*Service` interfaces, not concrete classes
- **Specific exceptions**: Services throw `DataNotFoundException`, `InvalidParamsException`, `PermissionDenyException` (not generic `Exception`)
- **Validation**: `@Valid` on controller params, `BindingResult` for error collection
- **API prefix**: all endpoints under `${api.prefix}` = `api/v1`
- **Response type**: `ResponseEntity<?>` for flexible return types
- **Error handling**: try-catch in controllers returning `ResponseEntity.badRequest().body(message)`
- **Mapping**: ModelMapper for Entity <-> DTO/Response conversion

### Security
- JWT-based stateless authentication (phone number as subject)
- Role-based access: `USER` and `ADMIN` roles
- Public endpoints: register, login, health check, GET products/categories/roles
- Admin-only: CRUD products, categories, orders management
- CORS: open to all origins (dev config)

### Database
- `ddl-auto: none` — schema managed manually, not by Hibernate
- Seed data in `data.sql` (roles, categories, admin user)
- Default admin: phone `09090909099`, password `123456`
- File uploads stored in `uploads/` directory, max 5 images per product

### i18n
- Message bundles: `src/main/resources/i18n/messages_{en,vi}.properties`
- Keys defined in `utils/MessageKeys.java`
- Resolved via `Accept-Language` header

## Configuration Files
- `application.yml` — MySQL dev config (port 8088)
- `application-render.yml` — PostgreSQL prod config (uses env vars)
- `docker-compose.yml` — MySQL + app containers

## Important Notes
- Server runs on port **8088** (not default 8080)
- MySQL runs on port **3307** (not default 3306)
- JWT secret key is hardcoded in application.yml (dev only)
- Phone-based auth (phone number = username)
- Soft delete for orders (active flag)
