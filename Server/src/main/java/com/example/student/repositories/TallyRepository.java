package com.example.student.repositories;

import com.example.student.entities.Tally;
import java.util.Set;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TallyRepository extends JpaRepository<Tally, Integer> {

    Set<Tally> getAllByTalliedUserName(String name);

    boolean existsByTalliedUserName(String name);
}
