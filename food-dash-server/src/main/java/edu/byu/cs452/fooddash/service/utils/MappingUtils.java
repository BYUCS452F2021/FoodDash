package edu.byu.cs452.fooddash.service.utils;

import edu.byu.cs452.fooddash.service.exceptions.UnauthorizedException;
import edu.byu.cs452.fooddash.web.security.FirebaseAuthentication;
import org.springframework.security.core.context.ReactiveSecurityContextHolder;
import reactor.core.publisher.Mono;

public class MappingUtils {

  public static Mono<String> mapSecurityContextToUid() {
    return ReactiveSecurityContextHolder.getContext()
        .filter(
            context ->
                context.getAuthentication() instanceof FirebaseAuthentication
                    && context.getAuthentication().getPrincipal() != null)
        .switchIfEmpty(Mono.error(new UnauthorizedException("Session is unauthorized")))
        .map(context -> (String) context.getAuthentication().getPrincipal());
  }
}
