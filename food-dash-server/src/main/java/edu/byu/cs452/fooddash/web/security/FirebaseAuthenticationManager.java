package edu.byu.cs452.fooddash.web.security;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import java.util.Collections;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.authentication.ReactiveAuthenticationManager;
import org.springframework.security.authentication.TestingAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.server.resource.BearerTokenAuthenticationToken;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

@Slf4j
@Component
public class FirebaseAuthenticationManager implements ReactiveAuthenticationManager {

  @Override
  public Mono<Authentication> authenticate(Authentication authentication)
      throws AuthenticationException {
    log.info("Authenticating: {}", authentication);
    if (!supports(authentication.getClass())) {
      return null;
    }
    FirebaseToken token;
    String bearer = (String) authentication.getPrincipal();
    if ("testToken".equals(bearer)) {
      log.info("Test token used for authentication");
      return Mono.just(
          new TestingAuthenticationToken(
              "test",
              "testToken",
              Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER"))));
    }

    try {
      log.info("Calling Firebase to verify token");
      token = FirebaseAuth.getInstance().verifyIdToken(bearer);
    } catch (FirebaseAuthException e) {
      log.info("Error in authenticating token", e);
      throw new AuthenticationCredentialsNotFoundException(
          "Failed to authenticate token: " + bearer, e);
    }
    log.info(
        "Authenticated with Firebase. Token returned: {}",
        token); // TODO delete this log for security in production
    return Mono.just(
        new FirebaseAuthentication(
            token, Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER"))));
  }

  public boolean supports(Class<?> authentication) {
    return (BearerTokenAuthenticationToken.class.isAssignableFrom(authentication));
  }
}
