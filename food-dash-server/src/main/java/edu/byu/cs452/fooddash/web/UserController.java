package edu.byu.cs452.fooddash.web;

import org.springframework.web.bind.annotation.*;

import edu.byu.cs452.fooddash.domain.model.User;
import edu.byu.cs452.fooddash.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import reactor.core.publisher.Mono;

@RestController
@RequestMapping(path = "user")
public class UserController {
    private final UserService userService;

    public UserController(UserService service) {
        this.userService = service;
    }

    @Operation(description = "Retrieve a User from database")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200", description = "Retrieved User"),
            @ApiResponse(responseCode = "400", description = "Invalid request", content = @Content),
            @ApiResponse(responseCode = "401", description = "Invalid Auth Header",
                    content = @Content)})
    @GetMapping
    public Mono<User> getUserInfo() {
        return userService.getUserDetailsById();
    }

    @Operation(description = "Persist an User favorite restaurant in database")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200", description = "Updated User"),
            @ApiResponse(responseCode = "400", description = "Invalid request", content = @Content),
            @ApiResponse(responseCode = "401", description = "Invalid Auth Header",
                    content = @Content)})
    @PutMapping(path = "/favorite/{id}")
    public Mono<User> addToFav(@PathVariable String id) {
        return userService.addRestaurantToFav(id);
    }

    @Operation(description = "Delete an favorite restaurant in database")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Deletion Success",
                    content = @Content),
            @ApiResponse(responseCode = "400", description = "Invalid request", content = @Content),
            @ApiResponse(responseCode = "401", description = "Not authorized to delete restaurant",
                    content = @Content),
            @ApiResponse(responseCode = "404", description = "Restaurant not found", content = @Content)})
    @DeleteMapping(path = "/favorite/{id}")
    public Mono<User> deleteFav(@PathVariable String id) {
        return userService.deleteRestaurantFromFav(id);
    }
}
