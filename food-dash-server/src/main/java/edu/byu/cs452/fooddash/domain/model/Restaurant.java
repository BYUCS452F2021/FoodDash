package edu.byu.cs452.fooddash.domain.model;

import java.util.ArrayList;
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
  private String id;
  private String name;
  private List<String> tags;
  private String description;
  private List<String> images;
  private List<String> reviews;

  public Restaurant addToReviews(String reviewId) {
    if (reviews == null) {
      reviews = new ArrayList<>();
    }
    reviews.add(reviewId);
    return this;
  }
}
