package com.example.student.repositories;

import com.example.student.entities.Reservation;
import com.example.student.entities.ReservationKey;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;
import java.util.List;

@Transactional
public interface ReservationRepository extends JpaRepository<Reservation, Integer> {

    Reservation findByReservationKey(ReservationKey reservationKey);

    List<Reservation> findAllByReservationKeyGroupId(int groupId);

}