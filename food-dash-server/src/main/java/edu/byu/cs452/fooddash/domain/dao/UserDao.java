package edu.byu.cs452.fooddash.domain.dao;

import org.springframework.data.repository.reactive.ReactiveCrudRepository;

import edu.byu.cs452.fooddash.domain.model.User;

public interface UserDao extends ReactiveCrudRepository<User, String> {

}
