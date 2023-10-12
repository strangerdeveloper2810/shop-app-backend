package com.shopapp.shopapp;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/v1/categories")
public class CategoryController {
//    Hiển thị tất cả category
    @GetMapping("")
    public ResponseEntity<String> getAllCategories() {
        return ResponseEntity.ok("Chào bạn");
    }

    @PostMapping()
    public ResponseEntity<String> insertCategories() {
        return ResponseEntity.ok("This is insert categories");
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateCategories(@PathVariable Long id) {
        return ResponseEntity.ok("This is update categories with id = "+id);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteCategories(@PathVariable Long id) {
        return ResponseEntity.ok("This is delete categories with id = "+id);
    }


}
