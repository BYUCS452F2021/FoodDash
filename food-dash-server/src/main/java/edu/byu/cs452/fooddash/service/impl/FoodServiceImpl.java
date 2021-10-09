package edu.byu.cs452.fooddash.service.impl;

import org.springframework.data.r2dbc.repository.Query;

import edu.byu.cs452.fooddash.domain.dao.FoodDao;
import edu.byu.cs452.fooddash.domain.model.Food;
import edu.byu.cs452.fooddash.service.FoodService;
import reactor.core.publisher.Flux;

public class FoodServiceImpl implements FoodService {

   private final FoodDao foodDao;

   public FoodServiceImpl(FoodDao foodDao) {
     this.foodDao = foodDao;
   }

   @Override
   public Flux<Food> getRestaurantMenu(String restaurantId) {
      return foodDao.getRestaurantMenu(restaurantId);
   }
}