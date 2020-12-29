package com.example.student.exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code = HttpStatus.NOT_FOUND, reason = "User not found")
public class UserNotFoundException extends RuntimeException{

    public UserNotFoundException() {
        super();
    }

    public UserNotFoundException(int userId) {
        super("Could not find user with id: " + userId);
    }

    public UserNotFoundException(String username) {
        super("Could not find user with username: " + username);
    }


}
