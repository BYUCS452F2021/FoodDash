package edu.byu.cs452.fooddash.service;


import edu.byu.cs452.fooddash.domain.model.Restaurant;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface RestaurantService {

  /**
   * Return a restaurant by ID.
   *
   * @param id The id
   * @return The restaurant matching the ID
   */
  Mono<Restaurant> getRestaurantById(Integer id);
  Flux<Restaurant> getAllRestaurants();
  Mono<Restaurant> addRestaurant(Restaurant restaurant);
}
