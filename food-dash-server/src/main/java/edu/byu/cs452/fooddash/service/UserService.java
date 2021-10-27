package edu.byu.cs452.fooddash.service;

import edu.byu.cs452.fooddash.domain.dao.RestaurantDao;
import edu.byu.cs452.fooddash.domain.dao.UserDao;
import edu.byu.cs452.fooddash.domain.model.User;
import edu.byu.cs452.fooddash.service.exceptions.NotFoundException;
import edu.byu.cs452.fooddash.service.utils.MappingUtils;
import java.util.ArrayList;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

@Service
public class UserService {

  private final UserDao userDao;
  private final RestaurantDao restaurantDao;

  public UserService(UserDao userDao, RestaurantDao restaurantDao) {
    this.userDao = userDao;
    this.restaurantDao = restaurantDao;
  }

  public Mono<User> getUserDetailsById() {
    return null;
    // return MappingUtils.mapSecurityContextToUid()
    //     .flatMap(id -> userDao.findById(id).switchIfEmpty(Mono.just(new User().setUserID(id))));
  }

  public Mono<User> addRestaurantToFav(Integer restaurantId) {
    return MappingUtils.mapSecurityContextToUid()
        .flatMap(
            uid ->
                restaurantDao
                    .findById(restaurantId)
                    .flatMap(
                        restaurant ->
                            userDao
                                .findById(uid)
                                .defaultIfEmpty(new User(uid, new ArrayList<>()))
                                .flatMap(
                                    user -> {
                                      user.addFavoriteRestaurant(restaurant.getId());
                                      return userDao.save(user);
                                    }))
                    .switchIfEmpty(Mono.error(new NotFoundException())))
        .switchIfEmpty(Mono.error(new NotFoundException()));
  }

  public Mono<User> deleteRestaurantFromFav(Integer restaurantId) {
    return MappingUtils.mapSecurityContextToUid()
        .flatMap(
            uid ->
                restaurantDao
                    .findById(restaurantId)
                    .flatMap(
                        restaurant ->
                            userDao
                                .findById(uid)
                                .switchIfEmpty(Mono.error(new NotFoundException()))
                                .flatMap(
                                    user -> {
                                      // user.getFavoriteRestaurants().remove(restaurant.getId());
                                      return userDao.save(user);
                                    }))
                    .switchIfEmpty(Mono.error(new NotFoundException())))
        .switchIfEmpty(Mono.error(new NotFoundException()));
  }
}
