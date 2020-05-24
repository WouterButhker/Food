package com.example.student.controllers;

import com.example.student.entities.User;
import com.example.student.repositories.UserRepository;
import com.sendgrid.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController

public class TestController {

    @Autowired
    UserRepository userRepository;

    @Value("${SENDGRID_API_KEY}")
    private String key;

    @GetMapping(path = "/login")
    public String test() {
        return userRepository.findByEmailAddress("Wouter").get().getId().toString();
    }

    @GetMapping(path = "/mail")
    public String mail() {
        //System.out.println(key);
        System.out.println("/mail");

        return "";
    }



}
