package edu.byu.cs452.fooddash.web;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import edu.byu.cs452.fooddash.domain.model.Food;
import edu.byu.cs452.fooddash.service.FoodService;
import reactor.core.publisher.Flux;


/** Controller used to query and persist restaurants. */
@RestController
@RequestMapping("/food")
public class FoodController {
   private final FoodService foodService;

   public FoodController(FoodService foodService) {
      this.foodService = foodService;
   }

   @GetMapping(path = "/menu/{id}")
   public Flux<Food> getRestaurantMenu(@PathVariable Integer restaurantId) {
     return foodService.getRestaurantMenu(restaurantId);
   }
}
