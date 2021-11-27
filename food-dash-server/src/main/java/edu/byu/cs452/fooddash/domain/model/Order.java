package edu.byu.cs452.fooddash.domain.model;

import com.google.cloud.firestore.annotation.DocumentId;
import java.time.LocalDate;
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
public class Order {
  public enum Status {
    PENDING,
    COMPLETE
  }

  @DocumentId private String id;
  private String userId;
  private Status status;
  private List<CartItem> cart;
  private LocalDate orderDate;
}
