package com.example.student.controllers;

import com.sendgrid.*;
import com.sendgrid.helpers.mail.Mail;
import com.sendgrid.helpers.mail.objects.Content;
import com.sendgrid.helpers.mail.objects.Email;
import com.sendgrid.helpers.mail.objects.Personalization;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class MailController {

    @Value("${SENDGRID_API_KEY}")
    private String key;

    @Value("${SENDGRID_REGISTRATION_TEMPLATE}")
    private String template;

    private SendGrid sendGrid;

    public MailController() {
        this.sendGrid = new SendGrid(key);
    }

    public void sendTemplateMail(String link) {
        Email from = new Email("wouterbuthker@gmail.com");
        String subject = "Welcome";
        Email to = new Email("wouterbuthker@live.nl");
        Personalization personalization = new Personalization();
        personalization.addTo(to);
        personalization.setSubject(subject);
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

            System.out.println(res.getStatusCode());
            System.out.println(res.getHeaders());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendMail(Email to, String subject, String link, Content content) {
        Email from = new Email("wouterbuthker@gmail.com");
        //Email to = new Email("wouterbuthker@live.nl");
        //String subject = "Subject";
        //Content content = new Content("text/plain", "Hoi Wouter");
        Mail mail = new Mail(from, subject, to, content);
        //mail.setTemplateId(template);



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


