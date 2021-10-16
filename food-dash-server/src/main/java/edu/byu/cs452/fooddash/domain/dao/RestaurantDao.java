package edu.byu.cs452.fooddash.domain.dao;

import edu.byu.cs452.fooddash.domain.model.Restaurant;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

public interface RestaurantDao extends ReactiveCrudRepository<Restaurant, Integer> {}
