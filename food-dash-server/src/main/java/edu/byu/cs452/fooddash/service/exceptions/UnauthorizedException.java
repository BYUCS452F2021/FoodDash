package edu.byu.cs452.fooddash.service.exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code = HttpStatus.UNAUTHORIZED, reason = "No proper Authentication given")
public class UnauthorizedException extends RuntimeException {

  public UnauthorizedException(String string) {
    super(string);
  }

  /** Default Serial Version */
  private static final long serialVersionUID = 1L;
}
