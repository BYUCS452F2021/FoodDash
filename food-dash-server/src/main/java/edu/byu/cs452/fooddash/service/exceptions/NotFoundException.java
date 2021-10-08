package edu.byu.cs452.fooddash.service.exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code = HttpStatus.NOT_FOUND, reason = "Resource not found")
public class NotFoundException extends RuntimeException {

  /** Default Serial Version */
  private static final long serialVersionUID = 1L;

  public NotFoundException() {
    super();
  }
}
