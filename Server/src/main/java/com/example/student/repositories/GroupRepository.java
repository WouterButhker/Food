package com.example.student.repositories;

import com.example.student.entities.Group;
import com.example.student.entities.GroupUserPermission;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Transactional
public interface GroupRepository extends JpaRepository<Group, Integer> {

    Optional<Group> findByName(String name);

    List<Group> findAllByGroupUserPermissionsIn(List<GroupUserPermission> groupUserPermissions);
}
