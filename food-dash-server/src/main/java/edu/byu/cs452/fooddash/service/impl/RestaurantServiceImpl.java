package edu.byu.cs452.fooddash.service.impl;

import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;

import edu.byu.cs452.fooddash.domain.dao.RestaurantDao;
import edu.byu.cs452.fooddash.domain.model.Restaurant;
import edu.byu.cs452.fooddash.service.RestaurantService;
import edu.byu.cs452.fooddash.service.exceptions.NotFoundException;
import lombok.extern.slf4j.Slf4j;
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
        return restaurantDao.findById(id)
                .switchIfEmpty(Mono.error(new NotFoundException()));
    }

}
