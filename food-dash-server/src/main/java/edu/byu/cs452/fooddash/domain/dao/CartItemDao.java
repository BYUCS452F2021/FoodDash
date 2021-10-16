package edu.byu.cs452.fooddash.domain.dao;


import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import edu.byu.cs452.fooddash.domain.model.CartItem;

public interface CartItemDao extends ReactiveCrudRepository<CartItem, Integer> {}
