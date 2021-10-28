package edu.byu.cs452.fooddash.service;

import edu.byu.cs452.fooddash.domain.model.Food;
import reactor.core.publisher.Flux;


public interface FoodService {
   Flux<Food> getRestaurantMenu(Integer restaurantId);
}
