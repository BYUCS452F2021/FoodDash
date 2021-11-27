package edu.byu.cs452.fooddash.domain.dao;

import static org.junit.jupiter.api.Assertions.assertEquals;

import edu.byu.cs452.fooddash.domain.model.Restaurant;
import java.util.ArrayList;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class RestaurantDaoTest {

  @Autowired RestaurantDao sut;

  @Test
  void testGet() {

    Restaurant restaurant =
        new Restaurant("id", "Cougareat", "TestAddress", "TestPhone", 5.0, new ArrayList<>());

    sut.save(restaurant).block();

    Restaurant returnValue = sut.findById("id").block();
    assertEquals("id", returnValue.getId());
    assertEquals("Cougareat", returnValue.getName());
  }
}
