package edu.byu.cs452.fooddash.domain.dao;

import edu.byu.cs452.fooddash.domain.model.User;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

public interface UserDao extends ReactiveCrudRepository<User, String> {}
