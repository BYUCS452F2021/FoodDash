package edu.byu.cs452.fooddash.service.impl;

import org.springframework.stereotype.Service;

import edu.byu.cs452.fooddash.domain.dao.FoodDao;
import edu.byu.cs452.fooddash.domain.model.Food;
import edu.byu.cs452.fooddash.service.FoodService;
import reactor.core.publisher.Flux;

@Service
public class FoodServiceImpl implements FoodService {

   private final FoodDao foodDao;

   public FoodServiceImpl(FoodDao foodDao) {
     this.foodDao = foodDao;
   }

   @Override
   public Flux<Food> getRestaurantMenu(Integer restaurantId) {
      return foodDao.getRestaurantMenu(restaurantId);
   }
}