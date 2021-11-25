package org.isetn.services;

import java.util.List;

import org.isetn.entities.User;

public interface UserService {
    User saveUser(User user);

    User getByEmailAndPassword(String email, String password);

    List<User> getAllUsers();
}
