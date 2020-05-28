package com.example.student.config;

import com.example.student.controllers.MailController;
import com.example.student.entities.User;
import com.example.student.entities.VerificationToken;
import com.example.student.repositories.VerificationTokenRepository;
import com.sendgrid.helpers.mail.objects.Email;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.UUID;

// TODO: refactor
@Component
public class RegistrationListener implements ApplicationListener<OnRegistrationCompleteEvent> {

    @Autowired
    private VerificationTokenRepository verificationTokenRepository;

    @Autowired
    private MailController mailController;
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
        String confirmationUrl = event.getAppUrl() + "/confirm?token=" + token;

        System.out.println("Sending mail to confirm registration");
        Email email = new Email(user.getEmailAddress());
        mailController.sendTemplateMail(confirmationUrl, email);

    }
}
