package com.shopapp.shopapp.controllers;

import com.shopapp.shopapp.dtos.OrderDTO;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("${api.prefix}/orders")
public class OrderController {
    @PostMapping("")
    public ResponseEntity<?> createOrder(@RequestBody @Valid OrderDTO orderDTO, BindingResult result) {
        try {
            if (result.hasErrors()) {
                List<String> errorMessages = result.getFieldErrors().stream().map(FieldError::getDefaultMessage).toList();
                return ResponseEntity.badRequest().body(errorMessages);
            }
            return ResponseEntity.ok("createOrder");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/{user_id}") // thêm đường dẫn "user_id"
    //GET http://localhost:8088/api/v1/orders/4
    public ResponseEntity<?> getOrders(@Valid @PathVariable("user_id") Long userId) {
        try {
            return ResponseEntity.ok("lấy ra danh sách order từ user_id");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }

    @PutMapping("/{id}")
    //PUT http://localhost:8088/api/v1/orders/2
    // công việc của admin
    public ResponseEntity<?> updateOrder(@Valid @PathVariable long id, @Valid @RequestBody OrderDTO orderDTO){
        return ResponseEntity.ok("Cập nhật thành công");
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteOrder(@Valid @PathVariable Long id) {
        // xoá mềm => cập nhật trường active = false;

        return ResponseEntity.ok("Order deleted successfully");
    }
}
