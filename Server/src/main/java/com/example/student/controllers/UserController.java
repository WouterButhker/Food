package com.example.student.controllers;

import com.example.student.config.OnRegistrationCompleteEvent;
import com.example.student.entities.Group;
import com.example.student.entities.GroupUserPermission;
import com.example.student.entities.User;
import com.example.student.entities.VerificationToken;
import com.example.student.exceptions.AlreadyExistsException;
import com.example.student.exceptions.VerificationFailedException;
import com.example.student.repositories.GroupRepository;
import com.example.student.repositories.GroupUserPermissionRepository;
import com.example.student.repositories.UserRepository;
import com.example.student.repositories.VerificationTokenRepository;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.net.http.HttpResponse;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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

    @Autowired
    VerificationTokenRepository verificationTokenRepository;

    @Autowired
    ApplicationEventPublisher eventPublisher;

    @PostMapping("/register")
    User addUser(@RequestBody String json, HttpServletRequest request) {
        try{
            User user = userRepository.save(parseUser(json));
            System.out.println("New user registered: " + user);

            String url = request.getRequestURL().toString();
            eventPublisher.publishEvent(new OnRegistrationCompleteEvent(user, url));

            return user;
        } catch (Exception e) {
            e.printStackTrace();
            throw new AlreadyExistsException();
        }
    }

    @GetMapping("/register/confirm")
    String confirmRegistration(@RequestParam String token) {
        VerificationToken verificationToken = verificationTokenRepository.findByToken(token);
        if (verificationToken == null) {
            System.out.println("Token is null");
            throw new VerificationFailedException();
        }

        User user = verificationToken.getUser();
        Calendar cal = Calendar.getInstance();
        long timeToVerifyLeft = verificationToken.getExpiryDate().getTime() - cal.getTime().getTime();

        if (timeToVerifyLeft < 0) {
            // TODO custom exception
            System.out.println("Time left to verify is " + new Date(timeToVerifyLeft).toString());
            throw new VerificationFailedException();
        }

        user.setAccountIsEnabled(true);
        userRepository.save(user);
        System.out.println("successfully verified user");

        return "Success";
    }

    private User parseUser(String json) {
        JsonObject obj = new Gson().fromJson(json, JsonObject.class);
        String email = obj.get("email").getAsString();
        String name = obj.get("name").getAsString();
        String pass = new BCryptPasswordEncoder().encode(obj.get("password").getAsString());
        return new User(email, name, pass, false);
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

//    @DeleteMapping(path = "/delete")
//    static User deleteUser(User user) {
//        userRepository.delete(user);
//        return user;
//    }
}
