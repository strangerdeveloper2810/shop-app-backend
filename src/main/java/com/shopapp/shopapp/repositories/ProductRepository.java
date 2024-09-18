package com.shopapp.shopapp.repositories;

import com.shopapp.shopapp.models.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, Long> {
    boolean existByName(String name);

    Page<Product> findAll(Pageable pageable); // phân trang
}
