package com.example.student.exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code = HttpStatus.INTERNAL_SERVER_ERROR, reason = "Failed to save resource")
public class FailedToSaveException extends RuntimeException {
    public FailedToSaveException(String message) {
        super(message);
    }

    public FailedToSaveException() {
        super();
    }
}
