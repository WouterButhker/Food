package com.example.student.controllers;

import com.example.student.entities.User;
import com.example.student.repositories.UserRepository;
import com.sendgrid.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController

public class TestController {

    @Autowired
    UserRepository userRepository;

    @Value("${SENDGRID_API_KEY}")
    private String key;

    @GetMapping(path = "/login")
    public String test() {
        return userRepository.findByEmailAddress("Wouter").get().getId().toString();
    }

    @GetMapping(path = "/mail")
    public String mail() {
        //System.out.println(key);
        Email from = new Email("wouterbuthker@gmail.com");
        Email to = new Email("wouterbuthker@live.nl");
        String subject = "Subject";
        Content content = new Content("text/plain", "Hoi Wouter");
        Mail mail = new Mail(from, subject, to, content);

        // TODO: REMOVE API KEY

        SendGrid sendGrid = new SendGrid(key);
        Request request = new Request();

        try {
            request.setMethod(Method.POST);
            request.setEndpoint("mail/send");
            request.setBody(mail.build());

            Response res = sendGrid.api(request);
            System.out.println(res.getStatusCode());
            System.out.println(res.getBody());
            System.out.println(res.getHeaders());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "";
    }



}
