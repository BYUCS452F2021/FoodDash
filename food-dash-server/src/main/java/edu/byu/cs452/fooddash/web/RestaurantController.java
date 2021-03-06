package edu.byu.cs452.fooddash.web;

import edu.byu.cs452.fooddash.domain.model.Food;
import edu.byu.cs452.fooddash.domain.model.Restaurant;
import edu.byu.cs452.fooddash.service.RestaurantService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

/** Controller used to query and persist restaurants. */
@RestController
@RequestMapping("/restaurant")
public class RestaurantController {

  private final RestaurantService restaurantService;

  public RestaurantController(RestaurantService service) {
    this.restaurantService = service;
  }

  @Operation(description = "Get a restaurant in database")
  @ApiResponses(
      value = {
        @ApiResponse(
            responseCode = "200",
            description = "The Restaurant requested",
            content = {
              @Content(
                  mediaType = "application/json",
                  schema = @Schema(implementation = Restaurant.class))
            }),
        @ApiResponse(responseCode = "400", description = "Invalid request", content = @Content),
        @ApiResponse(responseCode = "401", description = "Invalid Auth Header", content = @Content),
        @ApiResponse(responseCode = "404", description = "Restaurant not found", content = @Content)
      })
  @GetMapping(path = "/{id}")
  public Mono<Restaurant> getRestaurantById(@PathVariable String id) {
    return restaurantService.getRestaurantById(id);
  }

  @GetMapping()
  public Flux<Restaurant> getAllRestaurants() {
    return restaurantService.getAllRestaurants();
  }

  @PostMapping(path = "/{id}")
  public Flux<Food> getRestaurantMenu(@PathVariable String id) {
    return restaurantService.getRestaurantMenu(id);
  }

  @PostMapping()
  public Mono<Restaurant> addRestaurant(@RequestBody Restaurant restaurant) {
    return restaurantService.addRestaurant(restaurant);
  }
}
