package com.project.shopapp.controllers;

import com.project.shopapp.components.LocalizationUtils;
import com.project.shopapp.dtos.OrderDTO;
import com.project.shopapp.exceptions.PermissionDenyException;
import com.project.shopapp.models.Order;
import com.project.shopapp.models.Role;
import com.project.shopapp.models.User;
import com.project.shopapp.services.IOrderService;
import com.project.shopapp.utils.MessageKeys;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("${api.prefix}/orders")
@RequiredArgsConstructor
public class OrderController {
    private final IOrderService orderService;
    private final LocalizationUtils localizationUtils;

    @PostMapping("")
    public ResponseEntity<?> createOrder(@RequestBody @Valid OrderDTO orderDTO) {
        User authenticatedUser = getAuthenticatedUser();
        if (!authenticatedUser.getId().equals(orderDTO.getUserId())) {
            throw new PermissionDenyException("You can only create orders for yourself");
        }
        Order orderResponse = orderService.createOrder(orderDTO);
        return ResponseEntity.ok(orderResponse);
    }

    @GetMapping("/user/{user_id}")
    public ResponseEntity<?> getOrders(@PathVariable("user_id") Long userId) {
        User authenticatedUser = getAuthenticatedUser();
        if (!isAdminOrOwner(authenticatedUser, userId)) {
            throw new PermissionDenyException("You can only view your own orders");
        }
        List<Order> orders = orderService.findByUserId(userId);
        return ResponseEntity.ok(orders);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getOrder(@PathVariable("id") Long orderId) {
        Order existingOrder = orderService.getOrder(orderId);
        User authenticatedUser = getAuthenticatedUser();
        if (!isAdminOrOwner(authenticatedUser, existingOrder.getUser().getId())) {
            throw new PermissionDenyException("You can only view your own orders");
        }
        return ResponseEntity.ok(existingOrder);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateOrder(@PathVariable long id, @Valid @RequestBody OrderDTO orderDTO) {
        Order order = orderService.updateOrder(id, orderDTO);
        return ResponseEntity.ok(order);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteOrder(@PathVariable Long id) {
        orderService.deleteOrder(id);
        return ResponseEntity.ok(localizationUtils.getLocalizedMessage(MessageKeys.DELETE_ORDER_SUCCESSFULLY));
    }

    private User getAuthenticatedUser() {
        return (User) SecurityContextHolder.getContext()
                .getAuthentication().getPrincipal();
    }

    private boolean isAdminOrOwner(User authenticatedUser, Long ownerId) {
        boolean isAdmin = authenticatedUser.getRole().getName()
                .equalsIgnoreCase(Role.ADMIN);
        return isAdmin || authenticatedUser.getId().equals(ownerId);
    }
}
