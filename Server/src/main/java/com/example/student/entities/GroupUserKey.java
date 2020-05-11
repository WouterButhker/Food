package com.example.student.entities;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.criteria.CriteriaBuilder;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class GroupUserKey implements Serializable {

    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "group_id")
    private Integer groupId;

    public GroupUserKey() {

    }

    public GroupUserKey(int userKey, int groupKey) {
        this.userId = userKey;
        this.groupId = groupKey;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof GroupUserKey)) return false;
        GroupUserKey that = (GroupUserKey) o;
        return userId == that.userId &&
                groupId == that.groupId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, groupId);
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int user) {
        this.userId = user;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int group) {
        this.groupId = group;
    }
}
