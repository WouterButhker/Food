package com.example.student.controllers;

import com.example.student.entities.Tally;
import com.example.student.entities.User;
import com.example.student.exceptions.FailedToSaveException;
import com.example.student.exceptions.UserNotFoundException;
import com.example.student.repositories.TallyRepository;
import com.example.student.repositories.UserRepository;
import java.util.Optional;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TallyController {

    @Autowired
    TallyRepository tallyRepository;

    @Autowired
    UserRepository userRepository;

    @PostMapping(name = "/tally", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Tally addTally(@RequestBody Tally tally) {
        try {
            return tallyRepository.save(tally);
        } catch (DataAccessException e) {
            throw new FailedToSaveException(e.getMessage());
        }
    }

    @GetMapping(name = "/tally")
    public Set<Tally> getTalliesOnUser(@RequestParam int userId) {
        Optional<User> optionalUser = userRepository.findUserById(userId);
        if (optionalUser.isEmpty()) {
            throw new UserNotFoundException(userId);
        }

        return optionalUser.get().getTallies();
    }

    @GetMapping(name = "/tally")
    public Set<Tally> getTalliesOnGuest(@RequestParam String username) {
        if (!tallyRepository.existsByTalliedUserName(username)) throw new UserNotFoundException(username);
        return tallyRepository.getAllByTalliedUserName(username);
    }


}
