package com.example.student.controllers;


import com.example.student.entities.Group;
import com.example.student.exceptions.AlreadyExistsException;
import com.example.student.repositories.GroupRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/groups")
public class GroupController {

    @Autowired
    GroupRepository groupRepository;

    @PostMapping("/add")
    Group addGroup(@RequestBody Group group) {
        try{
            Group g = groupRepository.save(group);
            System.out.println(g);
            return g;
        } catch (Exception e) {
            throw new AlreadyExistsException();
        }

    }
}
