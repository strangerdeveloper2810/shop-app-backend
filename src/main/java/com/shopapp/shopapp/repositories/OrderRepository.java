package com.shopapp.shopapp.repositories;

import com.shopapp.shopapp.models.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    // tìm các đơn hàng của 1 user nào đó

    List<Order> findByUserId(Long userId);
}
