package edu.byu.cs452.fooddash.domain.dao;

import edu.byu.cs452.fooddash.domain.model.Food;
import reactor.core.publisher.Flux;

import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

public interface FoodDao extends ReactiveCrudRepository<Food, String> {
   @Query("SELECT * FROM FOOD WHERE restaurant_id = :restaurantId")
   Flux<Food> getRestaurantMenu(String restaurantId);
}
