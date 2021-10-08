package edu.byu.cs452.fooddash.service.exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code = HttpStatus.BAD_REQUEST, reason = "Request Invalid")
public class BadRequestException extends RuntimeException {

  public BadRequestException(String string) {
    super(string);
  }

  /** Default Serial Version */
  private static final long serialVersionUID = 1L;
}
