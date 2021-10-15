package edu.byu.cs452.fooddash.domain.model;

import java.math.BigDecimal;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

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
@Table
public class Restaurant {
  
  @Id
  private int restaurant_id;
  private String name;
  private String address;
  private String phone_number;
  private BigDecimal rating;
public Object getId() {
    return restaurant_id;
}

}
