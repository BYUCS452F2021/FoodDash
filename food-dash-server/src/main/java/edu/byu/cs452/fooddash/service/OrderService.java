package edu.byu.cs452.fooddash.service;

import edu.byu.cs452.fooddash.domain.model.Order;
import reactor.core.publisher.Mono;

public interface OrderService {
   Mono<Order> addOrder(Order order);
}
