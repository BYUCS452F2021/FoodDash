package edu.byu.cs452.fooddash.service.impl;

import edu.byu.cs452.fooddash.domain.dao.RestaurantDao;
import edu.byu.cs452.fooddash.domain.model.Food;
import edu.byu.cs452.fooddash.domain.model.Restaurant;
import edu.byu.cs452.fooddash.service.RestaurantService;
import edu.byu.cs452.fooddash.service.exceptions.NotFoundException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Slf4j
@Service
@Profile("!dev")
public class RestaurantServiceImpl implements RestaurantService {

  private final RestaurantDao restaurantDao;

  public RestaurantServiceImpl(RestaurantDao restaurantDao) {
    this.restaurantDao = restaurantDao;
  }

  @Override
  public Mono<Restaurant> getRestaurantById(String id) {
    log.debug("GetRestaurantById called with id {}", id);
    return restaurantDao.findById(id).switchIfEmpty(Mono.error(new NotFoundException()));
  }

  @Override
  public Flux<Restaurant> getAllRestaurants() {
    return restaurantDao.findAll();
  }

  @Override
  public Mono<Restaurant> addRestaurant(Restaurant restaurant) {
    return restaurantDao.save(restaurant);
  }

  @Override
  public Flux<Food> getRestaurantMenu(String id) {
    return restaurantDao
        .findById(id)
        .flatMapMany(restaurant -> Flux.fromIterable(restaurant.getMenu()))
        .switchIfEmpty(Flux.error(new NotFoundException()));
  }
}
