package edu.byu.cs452.fooddash.web;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
    return this.orderService.changeOrderStatus(order);
  }
}
