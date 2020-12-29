package com.example.student.entities;

import java.util.Date;
import java.util.Objects;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Tally {

    @Id
    @Column
    private Integer id;

    @ManyToOne
    @JoinColumn(nullable = false)
    private User tallyCreator;

    @ManyToOne
    @JoinColumn
    private User talliedUser;

    @Column
    private String talliedUserName;

    @Column(nullable = false)
    private int amount;

    @Column
    private String reason;

    @Column(nullable = false)
    private Date date;

    public Tally() {

    }

    public Tally(User tallyCreator, User talliedUser, int amount, String reason, Date date) {
        this.tallyCreator = tallyCreator;
        this.talliedUser = talliedUser;
        this.amount = amount;
        this.reason = reason;
        this.date = date;
    }

    public Tally(User tallyCreator, String talliedUserName, int amount, String reason, Date date) {
        this.tallyCreator = tallyCreator;
        this.talliedUserName = talliedUserName;
        this.amount = amount;
        this.reason = reason;
        this.date = date;
    }

    public Tally(User tallyCreator, String talliedUserName, String reason, Date date) {
        this(tallyCreator, talliedUserName, 1, reason, date);
    }

    public Tally(User tallyCreator, User talliedUser, String reason, Date date) {
        this(tallyCreator, talliedUser, 1, reason, date);
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getTallyCreator() {
        return tallyCreator;
    }

    public void setTallyCreator(User tallyCreator) {
        this.tallyCreator = tallyCreator;
    }

    public User getTalliedUser() {
        return talliedUser;
    }

    public void setTalliedUser(User talliedUser) {
        this.talliedUser = talliedUser;
    }

    public String getTalliedUserName() {
        return talliedUserName;
    }

    public void setTalliedUserName(String talliedUserName) {
        this.talliedUserName = talliedUserName;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Tally)) return false;
        Tally tally = (Tally) o;
        return amount == tally.amount && id.equals(tally.id) && tallyCreator.equals(tally.tallyCreator) && Objects.equals(talliedUser, tally.talliedUser) && Objects.equals(talliedUserName, tally.talliedUserName) && Objects.equals(reason, tally.reason) && date.equals(tally.date);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, tallyCreator, talliedUser, talliedUserName, amount, reason, date);
    }

    @Override
    public String toString() {
        return "Tally{" +
                "id=" + id +
                ", tallyCreator=" + tallyCreator +
                ", talliedUser=" + talliedUser +
                ", talliedUserName='" + talliedUserName + '\'' +
                ", amount=" + amount +
                ", reason='" + reason + '\'' +
                ", date=" + date +
                '}';
    }
}
