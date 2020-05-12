package com.example.student.controllers;

import com.example.student.entities.Group;
import com.example.student.entities.Reservation;
import com.example.student.entities.ReservationKey;
import com.example.student.entities.User;
import com.example.student.exceptions.GroupNotFoundException;
import com.example.student.exceptions.IncorrectDateException;
import com.example.student.exceptions.UserNotFoundException;
import com.example.student.repositories.GroupRepository;
import com.example.student.repositories.ReservationRepository;
import com.example.student.repositories.UserRepository;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;
import java.awt.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

@RestController
public class ReservationController {

    @Autowired
    UserRepository userRepository;

    @Autowired
    GroupRepository groupRepository;

    @Autowired
    ReservationRepository reservationRepository;

    @PostConstruct
    private void init() {
        User user = new User("Wouter", "Wouter B.", new BCryptPasswordEncoder().encode("123"), true);
        userRepository.save(user);
        Group group = new Group("Samballen");
        groupRepository.save(group);
        userRepository.flush();
        groupRepository.flush();
    }


    @PutMapping(path = "/reserve", consumes = MediaType.APPLICATION_JSON_VALUE)
    void makeReservation(@RequestBody String json) {
        System.out.println(json);
        //Reservation res = new Gson().fromJson(json, Reservation.class);

        Reservation res = parseReservation(json);
        //System.out.println(res);
        reservationRepository.save(res);
        res = reservationRepository.findAll().get(0);
        System.out.println(res);


//        Group g = groupRepository.findByName("Group1").get();
//        User p = userRepository.findUserById(1);
//
//        Date date = new Date(System.currentTimeMillis());
//        Reservation res = new Reservation(p, g, date, 0, 1);
//        reservationRepository.save(res);
//
//        res = reservationRepository.findAll().get(0);
//        System.out.println(res);
//        System.out.println(res.getReservationKey().getMyDate());

    }

    private Reservation parseReservation(String json)
            throws UserNotFoundException, GroupNotFoundException, IncorrectDateException {
        JsonObject obj = new Gson().fromJson(json, JsonObject.class);
        int userInt = obj.get("user").getAsInt();
        String groupStr = obj.get("group").getAsString();

        if (userRepository.findUserById(userInt).isEmpty()) {
            throw new UserNotFoundException();
        }
        if (groupRepository.findByName(groupStr).isEmpty()) {
            throw new GroupNotFoundException();
        }

        User user = userRepository.findUserById(userInt).get();
        Group group = groupRepository.findByName(groupStr).get();

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        Date date = new Date();
        try {
            date = formatter.parse(obj.get("date").getAsString());
        } catch (ParseException e) {
            throw new IncorrectDateException();
        }

        return new Reservation(user, group,
                date,
                obj.get("amountCooking").getAsInt(), obj.get("amountEating").getAsInt());
    }
}
