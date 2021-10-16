package edu.byu.cs452.fooddash.domain.dao;

import edu.byu.cs452.fooddash.domain.model.Food;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

public interface FoodDao extends ReactiveCrudRepository<Food, Integer> {}
