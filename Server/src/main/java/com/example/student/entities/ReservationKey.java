package com.example.student.entities;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.io.Serializable;
import java.util.Date;
import java.util.Objects;

@Embeddable
public class ReservationKey implements Serializable {

    @Column(name = "my_date")
    @Temporal(TemporalType.DATE)
    private Date myDate;

    @Column(name = "group_id")
    private Integer groupId;

    @Column(name = "user_id")
    private Integer userId;

    public ReservationKey() {

    }

    public ReservationKey(Date myDate, int groupId, int userId) {
        this.myDate = myDate;
        this.groupId = groupId;
        this.userId = userId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof ReservationKey)) return false;
        ReservationKey that = (ReservationKey) o;
        return groupId == that.groupId &&
                userId == that.userId &&
                Objects.equals(myDate, that.myDate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(myDate, groupId, userId);
    }

    public Date getMyDate() {
        return myDate;
    }

    public void setMyDate(Date date) {
        this.myDate = date;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
