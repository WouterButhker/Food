package com.example.student.controllers;

import com.example.student.repositories.GroupUserPermissionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GroupUserPermissionController {

    @Autowired
    GroupUserPermissionRepository groupUserPermissionRepository;


}
