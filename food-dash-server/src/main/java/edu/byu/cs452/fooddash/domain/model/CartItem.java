package edu.byu.cs452.fooddash.domain.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import lombok.experimental.SuperBuilder;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
@SuperBuilder
@Table
public class CartItem {

  @Id private int cartItem_id;
  private int order_id;
  private int food_id;
  private int quantity;
  private String notes;
}
