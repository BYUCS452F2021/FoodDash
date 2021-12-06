package edu.byu.cs452.fooddash.domain.model;

import com.google.cloud.firestore.annotation.DocumentId;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class User {
  @DocumentId private String id;
  private String name;
  private String address;
  private String phoneNumber;
  private List<Restaurant> favoriteRestaurants;

  public void addFavoriteRestaurant(Restaurant restaurant) {}

  public User(String uid, Object object) {}
}
