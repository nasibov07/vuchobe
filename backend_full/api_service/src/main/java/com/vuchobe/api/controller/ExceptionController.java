package com.vuchobe.api.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.mapping.PropertyReferenceException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.util.ArrayList;
import java.util.List;

@ControllerAdvice
public class ExceptionController extends ResponseEntityExceptionHandler {
    private static final Logger logger
            = LoggerFactory.getLogger(ExceptionController.class);

    @ExceptionHandler({PropertyReferenceException.class})
    public ResponseEntity<Object> errorPropertyReferenceException(PropertyReferenceException exception, WebRequest request) {
        logger.error(exception.getMessage());
        List<String> errors = new ArrayList<>();
        errors.add(exception.getMessage());

        return handleExceptionInternal(exception, errors,
                new HttpHeaders(), HttpStatus.INTERNAL_SERVER_ERROR, request);
    }

    @ExceptionHandler({UsernameNotFoundException.class})
    public ResponseEntity<Object> errorException(UsernameNotFoundException exception, WebRequest request) {
        logger.error(exception.getMessage());
        return handleExceptionInternal(exception, exception.getMessage(),
                new HttpHeaders(), HttpStatus.FORBIDDEN, request);
    }

    @ExceptionHandler({Throwable.class})
    public ResponseEntity<Object> errorException(Exception exception, WebRequest request) {
        logger.error(exception.getMessage());
        return handleExceptionInternal(exception, exception.getMessage(),
                new HttpHeaders(), HttpStatus.INTERNAL_SERVER_ERROR, request);
    }
}
