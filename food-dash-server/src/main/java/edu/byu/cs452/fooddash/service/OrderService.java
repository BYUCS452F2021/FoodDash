package edu.byu.cs452.fooddash.service;

import edu.byu.cs452.fooddash.domain.model.Order;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface OrderService {
   Flux<Order> listOrders();
   Mono<Order> addOrder(Order order);
   Mono<Order> changeOrderStatus(Order order);

}
