package com.example.student.controllers;

import com.example.student.entities.User;
import com.example.student.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController

public class TestController {

    @Autowired
    UserRepository userRepository;

    @GetMapping(path = "/login")
    public String test() {
        System.out.println("PRINT HALLO");
        return userRepository.findByEmailAddress("Wouter").get().getId().toString();
    }



}
