package edu.byu.cs452.fooddash.domain.dao;

import edu.byu.cs452.fooddash.domain.model.CartItem;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

public interface CartItemDao extends ReactiveCrudRepository<CartItem, Integer> {}
