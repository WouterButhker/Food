package com.example.student.controllers;

import com.sendgrid.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class MailController {

    @Value("${SENDGRID_API_KEY}")
    private String key;

    private SendGrid sendGrid;

    public MailController() {
        this.sendGrid = new SendGrid(key);
    }

    public void sendMail(Email to, String subject, Content content) {
        Email from = new Email("wouterbuthker@gmail.com");
        //Email to = new Email("wouterbuthker@live.nl");
        //String subject = "Subject";
        //Content content = new Content("text/plain", "Hoi Wouter");
        Mail mail = new Mail(from, subject, to, content);

        Request request = new Request();

        try {
            request.setMethod(Method.POST);
            request.setEndpoint("mail/send");
            request.setBody(mail.build());

            Response res = new SendGrid(key).api(request);
            System.out.println(res.getStatusCode());
            System.out.println(res.getHeaders());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
