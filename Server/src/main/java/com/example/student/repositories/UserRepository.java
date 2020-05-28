package com.example.student.repositories;

import com.example.student.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Transactional
public interface UserRepository extends JpaRepository<User, Integer> {

    Optional<User> findUserById(Integer userId);

    User findByEmailAddress(String emailAddress);

    boolean deleteByEmailAddress(String emailAddress);

    boolean existsByEmailAddress(String emailAddress);

}
