package edu.byu.cs452.fooddash;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.ExternalDocumentation;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import java.util.Arrays;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.data.elasticsearch.ReactiveElasticsearchRepositoriesAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.web.reactive.config.EnableWebFlux;

@SpringBootApplication(exclude = {ReactiveElasticsearchRepositoriesAutoConfiguration.class})
@EnableWebFlux
public class FoodDashServerApplication {

  @Bean
  public OpenAPI customOpenAPI() {
    return new OpenAPI()
        .info(
            new Info()
                .title("Food Dash API")
                .description("API for client calls to server.")
                .version("v0.0.1"))
        .externalDocs(
            new ExternalDocumentation()
                .description("Project GitHub Repo")
                .url("https://github.com/BYUCS452F2021/FoodDash"))
        .components(
            new Components()
                .addSecuritySchemes(
                    "bearer-key",
                    new SecurityScheme()
                        .type(SecurityScheme.Type.HTTP)
                        .scheme("bearer")
                        .bearerFormat("JWT")))
        .addSecurityItem(
            new SecurityRequirement().addList("bearer-key", Arrays.asList("read", "write")));
  }

  public static void main(String[] args) {
    SpringApplication.run(FoodDashServerApplication.class, args);
  }
}
