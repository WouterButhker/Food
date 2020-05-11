package com.example.student.entities;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "user_group")
public class Group {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true)
    private Integer id;


    @Column(name = "name", nullable = false)
    private String name;

    @OneToMany(mappedBy = "group")
    Set<GroupUserPermission> groupUserPermissions = new HashSet<>();

    @OneToMany(mappedBy = "group")
    Set<Reservation> reservations = new HashSet<>();

    public Group() {
    }

    public Group(String name) {
        this.name = name;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<GroupUserPermission> getGroupUserPermissions() {
        return groupUserPermissions;
    }

    public void setGroupUserPermissions(Set<GroupUserPermission> groupUserPermissions) {
        this.groupUserPermissions = groupUserPermissions;
    }

    public Set<Reservation> getReservations() {
        return reservations;
    }

    public void setReservations(Set<Reservation> reservations) {
        this.reservations = reservations;
    }

    @Override
    public String toString() {
        return "Group{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
