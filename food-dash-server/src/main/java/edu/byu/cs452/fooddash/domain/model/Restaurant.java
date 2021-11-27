package edu.byu.cs452.fooddash.domain.model;

import com.google.cloud.firestore.annotation.DocumentId;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import lombok.experimental.SuperBuilder;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
@SuperBuilder
public class Restaurant {

  @DocumentId private String id;
  private String name;
  private String address;
  private String phoneNumber;
  private double rating;
  private List<Food> menu;
}
