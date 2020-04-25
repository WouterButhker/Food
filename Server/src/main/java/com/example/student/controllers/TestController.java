package com.example.student.controllers;

import com.example.student.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/test")
public class TestController {

    @Autowired
    UserRepository userRepository;

    @GetMapping()
    public String test() {
        return "<h1>HALLO</h1>";
    }
}
