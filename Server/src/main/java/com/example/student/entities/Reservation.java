package com.example.student.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.Date;
import java.util.Objects;

@Entity
public class Reservation {

    @EmbeddedId
    ReservationKey reservationKey;

    @JsonIgnore
    @ManyToOne
    @MapsId("userId")
    @JoinColumn(name = "user_id")
    private User user;

    @JsonIgnore
    @ManyToOne
    @MapsId("groupId")
    @JoinColumn(name = "group_id")
    private Group group;

    @Column(name = "is_cooking")
    private boolean isCooking;

    @Column(name = "amount_eating")
    private int amountEating;

    public Reservation() {

    }

    public Reservation(User user, Group group, Date my_date, boolean isCooking, int amountEating) {
        this.reservationKey = new ReservationKey(my_date, user.getId(), group.getId());
        this.user = user;
        this.group = group;
        this.isCooking = isCooking;
        this.amountEating = amountEating;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Reservation)) return false;
        Reservation that = (Reservation) o;
        return isCooking == that.isCooking &&
                amountEating == that.amountEating &&
                Objects.equals(reservationKey, that.reservationKey) &&
                Objects.equals(user, that.user) &&
                Objects.equals(group, that.group);
                //Objects.equals(my_date, that.my_date);
    }

    @Override
    public int hashCode() {
        return Objects.hash(reservationKey, user, group, isCooking, amountEating);
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

    public boolean getIsCooking() {
        return isCooking;
    }

    public void setIsCooking(boolean amountCooking) {
        this.isCooking = amountCooking;
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
                ", isCooking=" + isCooking +
                ", amountEating=" + amountEating +
                '}';
    }
}
