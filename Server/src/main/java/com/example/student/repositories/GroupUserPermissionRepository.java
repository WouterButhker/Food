package com.example.student.repositories;

import com.example.student.entities.Group;
import com.example.student.entities.GroupUserPermission;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.persistence.criteria.CriteriaBuilder;
import javax.transaction.Transactional;
import java.util.List;

@Transactional
public interface GroupUserPermissionRepository extends JpaRepository<GroupUserPermission, Integer> {
    List<GroupUserPermission> findAllByGroup(Group group);

}
