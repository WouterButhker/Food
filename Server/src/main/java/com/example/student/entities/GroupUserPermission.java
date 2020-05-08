package com.example.student.entities;

import javax.persistence.*;
import java.util.Objects;

@Entity
public class GroupUserPermission {

    @EmbeddedId
    GroupUserKey id;

    @ManyToOne
    @MapsId("userId")
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @MapsId("groupId")
    @JoinColumn(name = "group_id")
    private Group group;

    @Column(name = "role")
    private String userRole;

    public GroupUserPermission() {

    }

    public GroupUserPermission(User user, Group group, String userRole) {
        this.user = user;
        this.group = group;
        this.userRole = userRole;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof GroupUserPermission)) return false;
        GroupUserPermission that = (GroupUserPermission) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(user, that.user) &&
                Objects.equals(group, that.group) &&
                Objects.equals(userRole, that.userRole);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, user, group, userRole);
    }

    public GroupUserKey getId() {
        return id;
    }

    public void setId(GroupUserKey id) {
        this.id = id;
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

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }
}
