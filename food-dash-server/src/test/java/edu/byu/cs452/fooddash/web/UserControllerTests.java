package edu.byu.cs452.fooddash.web;

import static org.junit.jupiter.api.Assertions.*;

import edu.byu.cs452.fooddash.domain.model.Restaurant;
import edu.byu.cs452.fooddash.domain.model.User;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.reactive.AutoConfigureWebTestClient;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.reactive.server.WebTestClient;
// We create a `@SpringBootTest`, starting an actual server on a `RANDOM_PORT`

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureWebTestClient(
    timeout = "60000") // Change this to a longer timeout if you are debugging
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@Disabled // Enable this test once test database and schema configured properly
public class UserControllerTests {

  // Spring Boot will create a `WebTestClient` for you,
  // already configure and ready to issue requests against "localhost:RANDOM_PORT"
  // You can choose to mutate if needed, the webTestClient in a BeforeEach method.
  @Autowired private WebTestClient webTestClient;

  private Restaurant restaurant;
  private User user;

  @Order(2)
  @Test
  public void addFav() {
    user =
        webTestClient
            .put()
            .uri(builder -> builder.path("/user/favorite/{id}").build(restaurant.getId()))
            .exchange()
            .expectStatus()
            .isOk()
            .returnResult(User.class)
            .getResponseBody()
            .blockFirst();

    assertNotNull(user);

    assertEquals(restaurant.getId(), user.getFavoriteRestaurants().get(0));
  }

  @Order(3)
  @Test
  public void deleteFav() {
    user =
        webTestClient
            .delete()
            .uri(builder -> builder.path("/user/favorite/{id}").build(restaurant.getId()))
            .exchange()
            .expectStatus()
            .isOk()
            .returnResult(User.class)
            .getResponseBody()
            .blockFirst();

    assertNotNull(user);
    assertTrue(
        user.getFavoriteRestaurants() == null || user.getFavoriteRestaurants().isEmpty(),
        "Favorite list should be empty");
  }
}
