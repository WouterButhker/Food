package com.example.student.repositories;

import com.example.student.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;
import java.util.Optional;

@Transactional
public interface UserRepository extends JpaRepository<User, Integer> {

    User findUserById(Integer userId);

    Optional<User> findByEmailAddress(String emailAddress);


}
