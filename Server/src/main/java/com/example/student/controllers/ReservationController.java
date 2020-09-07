package com.example.student.controllers;

import com.example.student.entities.Group;
import com.example.student.entities.Reservation;
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
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@RestController
public class ReservationController {

    @Autowired
    UserRepository userRepository;

    @Autowired
    GroupRepository groupRepository;

    @Autowired
    ReservationRepository reservationRepository;

//    @PostConstruct
//    private void init() {
//        User user = new User("Wouter", "Wouter B.", new BCryptPasswordEncoder().encode("123"), true);
//        userRepository.save(user);
//        Group group = new Group("Samballen");
//        groupRepository.save(group);
//        userRepository.flush();
//        groupRepository.flush();
//    }


    @PutMapping(path = "/reserve", consumes = MediaType.APPLICATION_JSON_VALUE)
    Reservation makeReservation(@RequestBody String json) throws Exception {

        Reservation res = parseReservation(json);
        res = reservationRepository.save(res);
        System.out.println("New reservation: " + res);

        return res;
    }

    @GetMapping(path = "/reservations/all")
    List<Reservation> getAllReservations(@RequestParam int groupId) {
        return reservationRepository.findAllByReservationKeyGroupId(groupId);
    }

    @DeleteMapping(path = "/reservations/delete")
    void deleteReservation(@RequestParam int groupId, @RequestParam String date, Principal principal) {

        User user = userRepository.findByEmailAddress(principal.getName());
        Date parsedDate = parseDate(date);

        Reservation res = reservationRepository.findByReservationKeyMyDateAndReservationKeyGroupIdAndUser(parsedDate, groupId, user);

        if (res != null) {
            reservationRepository.delete(res);
            System.out.println("DELETED reservation: " + res);
        }

    }

    private Reservation parseReservation(String json)
            throws UserNotFoundException, GroupNotFoundException, IncorrectDateException {
        JsonObject obj = new Gson().fromJson(json, JsonObject.class);
        int userInt = obj.get("userId").getAsInt();
        int groupId = obj.get("groupId").getAsInt();

        if (userRepository.findUserById(userInt).isEmpty()) {
            throw new UserNotFoundException();
        }
        if (groupRepository.findById(groupId).isEmpty()) {
            throw new GroupNotFoundException();
        }

        User user = userRepository.findUserById(userInt).get();
        Group group = groupRepository.findById(groupId).get();

        Date date = parseDate(obj.get("date").getAsString());

        return new Reservation(user, group,
                date,
                obj.get("isCooking").getAsBoolean(), obj.get("amountEating").getAsInt());
    }

    private Date parseDate(String date) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        try {
            Date newDate = formatter.parse(date);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(newDate);
            calendar.add(Calendar.HOUR, 12);
            return calendar.getTime();
        } catch (ParseException e) {
            throw new IncorrectDateException();
        }

    }
}
