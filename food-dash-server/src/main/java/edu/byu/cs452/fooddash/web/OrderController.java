package edu.byu.cs452.fooddash.web;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import edu.byu.cs452.fooddash.domain.model.Order;
import edu.byu.cs452.fooddash.service.OrderService;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

/** Controller used to query and persist restaurants. */
@RestController
@RequestMapping("/order")
public class OrderController {

  private final OrderService orderService;

  public OrderController(OrderService service) {
    this.orderService = service;
  }

  @GetMapping()
  public Flux<Order> listOrders() {
   return this.orderService.listOrders();
 }

  @PostMapping()
  public Mono<Order> addOrder(@RequestBody Order order) {
    return this.orderService.addOrder(order);
  }

  @PostMapping("/status")
  public Mono<Order> changeOrderStatus(@RequestBody Order order) {
   return this.orderService.changeOrderStatus(order);
  }
}
