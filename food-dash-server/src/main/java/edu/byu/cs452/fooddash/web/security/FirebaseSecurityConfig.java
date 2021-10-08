package edu.byu.cs452.fooddash.web.security;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import java.io.IOException;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.ReactiveAuthenticationManager;
import org.springframework.security.authentication.ReactiveAuthenticationManagerResolver;
import org.springframework.security.config.annotation.web.reactive.EnableWebFluxSecurity;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.web.server.SecurityWebFilterChain;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

@Configuration
@EnableWebFluxSecurity
// @EnableReactiveMethodSecurity may be used if we want our methods to be secure, not just our
// endpoints
public class FirebaseSecurityConfig {

  @Bean
  FirebaseApp createFireBaseApp() throws IOException {
    if (FirebaseApp.getApps().isEmpty()) {
      FirebaseOptions options =
          FirebaseOptions.builder()
              .setCredentials(GoogleCredentials.getApplicationDefault())
              .setServiceAccountId("amiable-archive-326601@appspot.gserviceaccount.com")
              .setProjectId("fooddash-6d428")
              .build();
      return FirebaseApp.initializeApp(options);
    }
    return FirebaseApp.getInstance();
  }

  @Bean
  public SecurityWebFilterChain securityWebFilterChain(
      ServerHttpSecurity http, ReactiveAuthenticationManagerResolver<ServerWebExchange> resolver) {
    http.csrf()
        .disable()
        .oauth2ResourceServer()
        .authenticationManagerResolver(resolver)
        .and()
        .authorizeExchange()
        .pathMatchers("/api")
        .permitAll()
        .pathMatchers("/swagger-ui/**", "/v3/api-docs/**")
        .permitAll()
        .pathMatchers("/webjars/swagger-ui/**")
        .permitAll()
        .pathMatchers("/actuator/**")
        .permitAll()
        .pathMatchers("/restaurants/**")
        .hasAnyRole("USER") // Can add any amount of roles here
        .anyExchange()
        .authenticated();
    return http.build();
  }

  @Bean
  ReactiveAuthenticationManagerResolver<ServerWebExchange> resolver(
      ReactiveAuthenticationManager manager) {
    return exchange -> Mono.just(manager);
  }
}
