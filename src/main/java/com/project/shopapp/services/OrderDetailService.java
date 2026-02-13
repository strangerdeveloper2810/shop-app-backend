package com.project.shopapp.services;

import com.project.shopapp.dtos.OrderDetailDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Order;
import com.project.shopapp.models.OrderDetail;
import com.project.shopapp.models.Product;
import com.project.shopapp.repository.OrderDetailRepository;
import com.project.shopapp.repository.OrderRepository;
import com.project.shopapp.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderDetailService implements IOrderDetailService{
    private final OrderDetailRepository orderDetailRepository;
    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    @Override
    public OrderDetail createOrderDetail(OrderDetailDTO orderDetailDTO) {
        // tìm xem orderId có tồn tại hay không
        Order order =
                orderRepository.findById(orderDetailDTO.getOrderId()).orElseThrow(()-> new DataNotFoundException(
                        "Can't find Order with id: " + orderDetailDTO.getOrderId()));

        // tìm product theo id
        Product product =
                productRepository.findById(orderDetailDTO.getProductId()).orElseThrow(()-> new DataNotFoundException(
                        "Can't find product with id: " +orderDetailDTO.getProductId()));

        OrderDetail orderDetail = OrderDetail.builder()
                .order(order)
                .product(product)
                .numberOfProducts(orderDetailDTO.getNumberOfProducts())
                .price(orderDetailDTO.getPrice())
                .totalMoney(orderDetailDTO.getTotalMoney())
                .color(orderDetailDTO.getColor())
                .build();

        // Lưu vào db
        return  orderDetailRepository.save(orderDetail);
    }

    @Override
    public OrderDetail getOrderDetail(Long id) {
        return orderDetailRepository.findById(id).orElseThrow(()-> new DataNotFoundException("Can't find OrderDetail " +
                "with id " +id));
    }

    @Override
    public OrderDetail updateOrderDetail(Long id, OrderDetailDTO orderDetailDTO) {
        // Tìm xem order detail có tồn tại hay kh

        OrderDetail existingOrderDetail =
                orderDetailRepository.findById(id).orElseThrow(()->new DataNotFoundException("Can't find order " +
                        "detail with id " +id));

        Order existingOrder =
                orderRepository.findById(orderDetailDTO.getOrderId()).orElseThrow(()-> new DataNotFoundException(
                        "Can't find order with id: " + orderDetailDTO.getOrderId()));

        Product existingProduct =
                productRepository.findById(orderDetailDTO.getProductId()).orElseThrow(()-> new DataNotFoundException(
                        "Can't find product with id: " +orderDetailDTO.getProductId()));

        existingOrderDetail.setPrice(orderDetailDTO.getPrice());
        existingOrderDetail.setNumberOfProducts(orderDetailDTO.getNumberOfProducts());
        existingOrderDetail.setTotalMoney(orderDetailDTO.getTotalMoney());
        existingOrderDetail.setColor(orderDetailDTO.getColor());
        existingOrderDetail.setOrder(existingOrder);
        existingOrderDetail.setProduct(existingProduct);
        return orderDetailRepository.save(existingOrderDetail);
    }

    @Override
    public void deleteOrderDetail(Long id) {
        orderDetailRepository.deleteById(id);
    }

    @Override
    public List<OrderDetail> findByOrderId(Long orderId) {
       return orderDetailRepository.findByOrderId(orderId);
    }
}
