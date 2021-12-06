package edu.byu.cs452.fooddash.web;

import edu.byu.cs452.fooddash.domain.model.Food;
import edu.byu.cs452.fooddash.service.RestaurantService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;

/** Controller used to query and persist restaurants. */
@RestController
@RequestMapping("/food")
public class FoodController {
  private final RestaurantService service;

  public FoodController(RestaurantService service) {
    this.service = service;
  }

  @GetMapping(path = "/menu/{id}")
  public Flux<Food> getRestaurantMenu(@PathVariable String restaurantId) {
    return service.getRestaurantMenu(restaurantId);
  }
}
