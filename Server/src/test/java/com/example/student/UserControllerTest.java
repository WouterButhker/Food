package com.example.student;

import com.example.student.config.SecurityConfiguration;
import com.example.student.controllers.UserController;
import com.example.student.entities.User;
import com.google.gson.Gson;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.web.context.WebApplicationContext;

import javax.transaction.Transactional;


import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.web.servlet.function.RequestPredicates.contentType;

@RunWith(SpringRunner.class)
@SpringBootTest()
@ContextConfiguration(classes = {
        StudentApplication.class,
        SecurityConfiguration.class,
        PlatformTransactionManager.class
})
@Transactional
public class UserControllerTest {

    @Autowired
    private WebApplicationContext context;

    private MockMvc mvc;

    User user = new User("W@h.com", "W.B.",
            new BCryptPasswordEncoder().encode("123"), true);

    @BeforeEach
    public void setup() {
        mvc = MockMvcBuilders
                .webAppContextSetup(context)
                .apply(springSecurity())
                .build();
    }


    User addUser(MockMvc mvc) throws Exception {
        String input = "{\"email\":\"p@inda\",\"name\":\"Pinda\",\"password\":\"pass\"}";
        return new Gson().fromJson(
                mvc.perform(post("/users/add")
                .contentType(MediaType.APPLICATION_JSON)
                .content(input))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse().getContentAsString(),
                User.class);
    }

    @Test
    void testAddUser() throws Exception {
        addUser(this.mvc);
    }
}
