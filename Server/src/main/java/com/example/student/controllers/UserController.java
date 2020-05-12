package com.example.student.controllers;

import com.example.student.entities.User;
import com.example.student.exceptions.AlreadyExistsException;
import com.example.student.repositories.UserRepository;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.http.HttpResponse;

@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    UserRepository userRepository;

    @PostMapping("/add")
    User AddUser(@RequestBody String json) {
        try{
            User u = userRepository.save(parseUser(json));
            System.out.println("New user registered: " + u);
            return u;
        } catch (Exception e) {
            e.printStackTrace();
            throw new AlreadyExistsException();
        }
    }

    private User parseUser(String json) {
        JsonObject obj = new Gson().fromJson(json, JsonObject.class);
        String email = obj.get("email").getAsString();
        String name = obj.get("name").getAsString();
        String pass = new BCryptPasswordEncoder().encode(obj.get("password").getAsString());
        return new User(email, name, pass, true);
    }
}
