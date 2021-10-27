package edu.byu.cs452.fooddash.domain.model;

import java.util.ArrayList;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
@Table
public class User {
  @Id private int user_id;
  private String name;
  private String address;
  private String phone_number;

  public void addFavoriteRestaurant(Object id) {}

  public User(String uid, Object object) {}

  public ArrayList<Restaurant> getFavoriteRestaurants() {
    return null;
  }
}
