package edu.byu.cs452.fooddash.domain.dao;


import edu.byu.cs452.fooddash.domain.model.Order;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

public interface OrderDao extends ReactiveCrudRepository<Order, Integer> {}
