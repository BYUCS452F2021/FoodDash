package edu.byu.cs452.fooddash.service.impl;

import edu.byu.cs452.fooddash.domain.dao.OrderDao;

import edu.byu.cs452.fooddash.domain.model.Order;
import edu.byu.cs452.fooddash.service.OrderService;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;

import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Service
@Profile("!dev")
public class OrderServiceImpl implements OrderService {

  private final OrderDao orderDao;

  public OrderServiceImpl(OrderDao orderDao) {
    this.orderDao = orderDao;
  }

@Override
public Mono<Order> addOrder(Order order) {
   return this.orderDao.save(order);
}

@Override
public Mono<Order> changeOrderStatus(Order order) {
   return this.orderDao.save(order);
<<<<<<< HEAD
}

@Override
public Flux<Order> listOrders() {
   return this.orderDao.findAll();
=======
>>>>>>> main
}}
