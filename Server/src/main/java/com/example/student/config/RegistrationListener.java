package com.example.student.config;

import com.example.student.controllers.MailController;
import com.example.student.entities.User;
import com.example.student.entities.VerificationToken;
import com.example.student.repositories.VerificationTokenRepository;
import com.sendgrid.Content;
import com.sendgrid.Email;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.UUID;

@Component
public class RegistrationListener implements ApplicationListener<OnRegistrationCompleteEvent> {

    @Autowired
    private VerificationTokenRepository verificationTokenRepository;

    @Autowired
    MailController mailController;

    /**
     * Handle an application event.
     *
     * @param event the event to respond to
     */
    @Override
    public void onApplicationEvent(OnRegistrationCompleteEvent event) {
        confirmRegistration(event);
    }

    private void confirmRegistration(OnRegistrationCompleteEvent event) {
        User user = event.getUser();
        String token = UUID.randomUUID().toString();
        verificationTokenRepository.save(new VerificationToken(token, user));

        // Email email = new Email(user.getEmail());
        Email email = new Email("wouterbuthker@live.nl");
        String subject = "Confirm registration";
        String confirmationUrl = event.getAppUrl() + "/users/register/confirm?token=" + token;
        String emailMessage = "Confirm your registration by clicking the following link\n" + confirmationUrl;
        Content content = new Content("text/plain", emailMessage);

        System.out.println("Sending mail to confirm registration");
        mailController.sendMail(email, subject, content);

    }
}
