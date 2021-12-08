package edu.byu.cs452.fooddash.web;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import edu.byu.cs452.fooddash.domain.model.Order;
import edu.byu.cs452.fooddash.service.OrderService;
import reactor.core.publisher.Mono;

/** Controller used to query and persist restaurants. */
@RestController
@RequestMapping("/order")
public class OrderController {

  private final OrderService orderService;

  public OrderController(OrderService service) {
    this.orderService = service;
  }

  @PostMapping()
  public Mono<Order> addOrder(@RequestBody Order order) {
    return this.orderService.addOrder(order);
  }

  @PostMapping("/status")
  public Mono<Order> changeOrderStatus(@RequestBody Order order) {
   System.out.println("I get here"); 
   return this.orderService.changeOrderStatus(order);
  }
}
