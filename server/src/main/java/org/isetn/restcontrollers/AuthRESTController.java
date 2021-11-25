package org.isetn.restcontrollers;

import org.isetn.entities.User;
import org.isetn.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
public class AuthRESTController {

    @Autowired
    UserService userService;

    @PostMapping("/register")
    public User Register(@RequestBody User user) {
        return userService.saveUser(user);
    }

    @PostMapping("/login")
    public User Login(@RequestBody User user) {
        User myUser = userService.getByEmailAndPassword(user.getEmail(), user.getPassword());
        if (myUser == null)
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        return myUser;
    }
}
