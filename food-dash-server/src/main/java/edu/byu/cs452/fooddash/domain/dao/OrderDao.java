package edu.byu.cs452.fooddash.domain.dao;

import com.google.cloud.spring.data.firestore.FirestoreReactiveRepository;
import edu.byu.cs452.fooddash.domain.model.Order;

public interface OrderDao extends FirestoreReactiveRepository<Order> {}
