package com.example.student.controllers;

import com.example.student.entities.Group;
import com.example.student.entities.GroupUserPermission;
import com.example.student.entities.User;
import com.example.student.exceptions.AlreadyExistsException;
import com.example.student.repositories.GroupRepository;
import com.example.student.repositories.GroupUserPermissionRepository;
import com.example.student.repositories.UserRepository;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    UserRepository userRepository;

    @Autowired
    GroupUserPermissionRepository groupUserPermissionRepository;

    @Autowired
    GroupRepository groupRepository;

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

    @GetMapping(path = "/getFromGroup")
    List<User> getFromGroup(@RequestParam int groupId) {
        Group group = groupRepository.findById(groupId).get();
        List<GroupUserPermission> list =  groupUserPermissionRepository.findAllByGroup(group);
        List<User> users = new ArrayList<>();
        list.forEach((GroupUserPermission i) -> users.add(i.getUser()));
        return users;
    }

    @GetMapping(path = "/get")
    User getTemp() {
        return userRepository.getOne(1);
    }
}
