package com.example.student.controllers;

import com.example.student.repositories.UserRepository;
import com.sendgrid.*;
import com.sendgrid.helpers.mail.Mail;
import com.sendgrid.helpers.mail.objects.Content;
import com.sendgrid.helpers.mail.objects.Email;
import com.sendgrid.helpers.mail.objects.Personalization;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class MailController {

    @Value("${SENDGRID_API_KEY}")
    private String key;

    @Value("${SENDGRID_REGISTRATION_TEMPLATE}")
    private String template;

    @Autowired
    private UserRepository userRepository;


    public void sendTemplateMail(String link, Email to) {
        Email from = new Email("wouterbuthker@gmail.com");
        from.setName("Woutertje");
        //to = new Email("wouterbuthker@live.nl"); // TODO remove


        Personalization personalization = new Personalization();
        personalization.addTo(to);
        personalization.addDynamicTemplateData("link", link);

        Mail mail = new Mail();
        mail.setTemplateId(template);
        mail.setFrom(from);
        mail.addPersonalization(personalization);

        Request request = new Request();

        try {
            request.setMethod(Method.POST);
            request.setEndpoint("mail/send");
            request.setBody(mail.build());


            Response res = new SendGrid(key).api(request);

            System.out.println("Mail sent to " + to.getEmail());
            System.out.println("Response: " + res.getStatusCode());


            if (res.getStatusCode() != 202) {
                System.out.println("Body: " + res.getBody());
                String s = "failed to send mail, deleting user ";
                boolean b = userRepository.deleteByEmailAddress(to.getEmail());
                System.out.println(s + b );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }


    }
}


