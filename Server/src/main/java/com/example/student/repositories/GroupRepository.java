package com.example.student.repositories;

import com.example.student.entities.Group;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;
import java.util.Optional;

@Transactional
public interface GroupRepository extends JpaRepository<Group, Integer> {

    Optional<Group> findByName(String name);
}
