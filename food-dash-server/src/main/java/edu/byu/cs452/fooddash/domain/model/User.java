package edu.byu.cs452.fooddash.domain.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain=true)
public class User {
    private String userID;
    private List<String> favoriteRestaurants;

    public User addFavoriteRestaurant(String restaurantId) {
        favoriteRestaurants.add(restaurantId);
        return this;
    }
}
