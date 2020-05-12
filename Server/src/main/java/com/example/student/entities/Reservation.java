package com.example.student.entities;

import javax.persistence.*;
import java.util.Date;
import java.util.Objects;

@Entity
public class Reservation {

    @EmbeddedId
    ReservationKey reservationKey;

    @ManyToOne
    @MapsId("userId")
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @MapsId("groupId")
    @JoinColumn(name = "group_id")
    private Group group;

    @Column(name = "amount_cooking")
    private int amountCooking;

    @Column(name = "amount_eating")
    private int amountEating;

    public Reservation() {

    }

    public Reservation(User user, Group group, Date my_date, int amountCooking, int amountEating) {
        this.reservationKey = new ReservationKey(my_date, user.getId(), group.getId());
        this.user = user;
        this.group = group;
        this.amountCooking = amountCooking;
        this.amountEating = amountEating;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Reservation)) return false;
        Reservation that = (Reservation) o;
        return amountCooking == that.amountCooking &&
                amountEating == that.amountEating &&
                Objects.equals(reservationKey, that.reservationKey) &&
                Objects.equals(user, that.user) &&
                Objects.equals(group, that.group);
                //Objects.equals(my_date, that.my_date);
    }

    @Override
    public int hashCode() {
        return Objects.hash(reservationKey, user, group, amountCooking, amountEating);
    }

    public ReservationKey getReservationKey() {
        return reservationKey;
    }

    public void setReservationKey(ReservationKey reservationKey) {
        this.reservationKey = reservationKey;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Group getGroup() {
        return group;
    }

    public void setGroup(Group group) {
        this.group = group;
    }

    public Date getDate() {
        return this.reservationKey.getMyDate();
    }

    public void setDate(Date date) {
        this.reservationKey.setMyDate(date);
    }

    public int getAmountCooking() {
        return amountCooking;
    }

    public void setAmountCooking(int amountCooking) {
        this.amountCooking = amountCooking;
    }

    public int getAmountEating() {
        return amountEating;
    }

    public void setAmountEating(int amountEating) {
        this.amountEating = amountEating;
    }

    @Override
    public String toString() {
        return "Reservation{" +
                "user=" + user +
                ", group=" + group +
                ", date='" + this.getDate() + "'" +
                ", amountCooking=" + amountCooking +
                ", amountEating=" + amountEating +
                '}';
    }
}
