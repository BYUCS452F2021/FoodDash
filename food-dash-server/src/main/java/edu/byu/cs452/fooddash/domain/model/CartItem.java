package edu.byu.cs452.fooddash.domain.model;

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
public class CartItem {

  private Food food;
  private int quantity;
  private String notes;
}
