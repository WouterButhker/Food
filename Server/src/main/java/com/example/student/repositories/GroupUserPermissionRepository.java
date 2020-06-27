package com.example.student.repositories;

import com.example.student.entities.Group;
import com.example.student.entities.GroupUserPermission;
import com.example.student.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;
import java.util.List;

@Transactional
public interface GroupUserPermissionRepository extends JpaRepository<GroupUserPermission, Integer> {

    List<GroupUserPermission> findAllByGroup(Group group);

    List<GroupUserPermission> findAllByUser(User user);

}
