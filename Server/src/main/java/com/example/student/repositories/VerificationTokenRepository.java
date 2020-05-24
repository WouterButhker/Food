package com.example.student.repositories;

import com.example.student.entities.VerificationToken;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VerificationTokenRepository extends JpaRepository<VerificationToken, Integer> {

    VerificationToken findByToken(String token);
}
