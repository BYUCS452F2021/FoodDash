package edu.byu.cs452.fooddash.domain.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.r2dbc.repository.config.EnableR2dbcRepositories;

@Configuration
@EnableR2dbcRepositories
class RepositoryConfiguration {
  //  extends AbstractR2dbcConfiguration {

  //     @Value("${db.connection}")
  //     private String connectionString;

  //     @Override
  //     @Bean
  //     public ConnectionFactory connectionFactory() {
  //         // connectionString looks like this:
  //         // r2dbc:gcp:postgres://user:123456@my-project:us-central1:r2dbctest/testdb
  //         ConnectionFactory connectionFactory = ConnectionFactories.get(connectionString);
  //         ConnectionPoolConfiguration configuration =
  // ConnectionPoolConfiguration.builder(connectionFactory)
  //                 .maxIdleTime(Duration.ofMillis(1000)).maxSize(10).build();

  //         return new ConnectionPool(configuration);
  //     }
}
