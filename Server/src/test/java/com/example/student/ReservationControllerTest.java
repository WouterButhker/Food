package com.example.student;

import com.example.student.config.SecurityConfiguration;
import com.example.student.controllers.UserController;
import com.example.student.entities.Group;
import com.example.student.entities.Reservation;
import com.example.student.entities.User;
import com.example.student.repositories.ReservationRepository;
import com.google.gson.Gson;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.web.context.WebApplicationContext;

import javax.transaction.Transactional;

import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringRunner.class)
@SpringBootTest()
@ContextConfiguration(classes = {
        StudentApplication.class,
        SecurityConfiguration.class,
        PlatformTransactionManager.class
})
@Transactional
public class ReservationControllerTest {

    @Autowired
    WebApplicationContext context;

    MockMvc mvc;

    @BeforeEach
    public void setup() {
        mvc = MockMvcBuilders
                .webAppContextSetup(context)
                .apply(springSecurity())
                .build();
    }

    Reservation addReservation() throws Exception {
        String input = "{\"user\":2,\"amountCooking\":0,\"amountEating\":1,\"group\"" +
                ":\"BIERR\",\"date\":\"2020-05-12T02:43:55.424861\"}";
        new UserControllerTest().addUser(mvc);
        new GroupControllerTest().addGroup(mvc);

        return new Gson().fromJson(mvc.perform(put("/reserve")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(input))
                        .andExpect(status().isOk())
                        .andReturn()
                        .getResponse().getContentAsString(),
                Reservation.class);
    }

    @Test
    @WithMockUser
    void testAddReservation() throws Exception {
        System.out.println(addReservation());
    }



}
