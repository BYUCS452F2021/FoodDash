package edu.byu.cs452.fooddash.web.security;

import com.google.firebase.auth.FirebaseToken;
import java.util.Collection;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

public class FirebaseAuthentication extends AbstractAuthenticationToken {

  /** Default Serial ID. */
  private static final long serialVersionUID = 1L;

  private final FirebaseToken token;

  public FirebaseAuthentication(
      FirebaseToken token, Collection<? extends GrantedAuthority> authorities) {
    super(authorities);
    this.token = token;
    setAuthenticated(true);
    setDetails(token);
  }

  @Override
  public Object getCredentials() {
    return token.getUid();
  }

  @Override
  public Object getPrincipal() {
    return token.getUid();
  }
}
