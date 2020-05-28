package com.example.student.controllers;


import com.example.student.entities.Group;
import com.example.student.entities.GroupUserPermission;
import com.example.student.entities.User;
import com.example.student.exceptions.AlreadyExistsException;
import com.example.student.repositories.GroupRepository;
import com.example.student.repositories.GroupUserPermissionRepository;
import com.example.student.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

@RestController
@RequestMapping("/groups")
public class GroupController {

    @Autowired
    GroupRepository groupRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    GroupUserPermissionRepository groupUserPermissionRepository;

    @PostMapping("/add")
    Group addGroup(@RequestBody Group group, Principal principal) {
        try{
            Group g = groupRepository.save(group);
            User user = userRepository.findByEmailAddress(principal.getName());
            GroupUserPermission permission = new GroupUserPermission(user, g, "Owner");
            groupUserPermissionRepository.save(permission);
            return g;
        } catch (Exception e) {
            throw new AlreadyExistsException();
        }

    }
}
