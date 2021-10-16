package edu.byu.cs452.fooddash.domain.dao;

import edu.byu.cs452.fooddash.domain.model.Restaurant;
import reactor.core.publisher.Mono;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class RestaurantDaoTest {
    
    @Autowired
    RestaurantDao sut;

    
    @Test
    void testGet() {
        Restaurant restauraunt = sut.findById(1).block();
        assertEquals(1, restauraunt.getId());
        assertEquals("Cougareat", restauraunt.getName());
    }
}
