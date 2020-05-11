package com.example.student.controllers;

import com.example.student.entities.Group;
import com.example.student.entities.Reservation;
import com.example.student.entities.ReservationKey;
import com.example.student.entities.User;
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

    }


    @PutMapping(path = "/reserve", consumes = MediaType.APPLICATION_JSON_VALUE)
    void makeReservation(@RequestBody String json) {
        System.out.println(json);
        //Reservation res = new Gson().fromJson(json, Reservation.class);

        //Reservation res = parseReservation(json);
        //System.out.println(res);
//        ReservationKey key =
//                new ReservationKey(res.getDate(), res.getGroup().getId(), res.getUser().getId());
        //reservationRepository.save(res);

        User user = new User("Wouter", new BCryptPasswordEncoder().encode("123"), true);
        userRepository.save(user);
        Group group = new Group("Group1");
        groupRepository.save(group);
        userRepository.flush();
        groupRepository.flush();

        Group g = groupRepository.findByName("Group1").get();
        User p = userRepository.findUserById(1);

        Date date = new Date(System.currentTimeMillis());
        Reservation res = new Reservation(p, g, date, 0, 1);
        reservationRepository.save(res);
        System.out.println(res);

    }

    private Reservation parseReservation(String json) {
        JsonObject obj = new Gson().fromJson(json, JsonObject.class);
        User w = userRepository.findUserById(obj.get("user").getAsInt());
        Group g = groupRepository.findByName(obj.get("group").getAsString()).get();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        Date date = new Date();
        try {
            date = formatter.parse(obj.get("date").getAsString());
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return new Reservation(w, g,
                date,
                obj.get("amountCooking").getAsInt(), obj.get("amountEating").getAsInt());
    }
}
