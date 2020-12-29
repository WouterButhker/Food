package com.example.student.entities;

import java.util.Calendar;
import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
public class VerificationToken {
    private static final int EXPIRATION = 60 * 24;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String token;

    @OnDelete(action = OnDeleteAction.CASCADE)
    @OneToOne(targetEntity = User.class, fetch = FetchType.EAGER)
    @JoinColumn(nullable = false, name = "user_id")
    User user;

    private Date expiryDate;

    private Date calcExpiryDate(int expiryTimeInMinutes) {
        Calendar calendar = Calendar.getInstance();
        //calendar.setTime(new Timestamp(calendar.getTime().getTime()));
        System.out.println("current time: " + calendar.getTime().toString());
        calendar.add(Calendar.MINUTE, expiryTimeInMinutes);
        System.out.println("expiry time: " + calendar.getTime().toString());
        return calendar.getTime();
    }

    public VerificationToken(String token, User user) {
        this.token = token;
        this.user = user;
        this.expiryDate  = calcExpiryDate(EXPIRATION);
    }

    public VerificationToken() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }
}
