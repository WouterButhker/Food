package com.example.student.repositories;

import com.example.student.entities.Reservation;
import com.example.student.entities.ReservationKey;
import com.example.student.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;
import java.util.Date;
import java.util.List;

@Transactional
public interface ReservationRepository extends JpaRepository<Reservation, Integer> {

    Reservation findByReservationKey(ReservationKey reservationKey);

    List<Reservation> findAllByReservationKeyGroupId(int groupId);

    Reservation findByReservationKeyMyDateAndReservationKeyGroupIdAndUser(Date date, int groupId, User user);

    Reservation deleteByReservationKeyMyDateAndReservationKeyGroupIdAndUser(Date date, int groupId, User user);



}
