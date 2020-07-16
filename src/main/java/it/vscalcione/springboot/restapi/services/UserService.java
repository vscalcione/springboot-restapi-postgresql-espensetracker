package it.vscalcione.springboot.restapi.services;

import it.vscalcione.springboot.restapi.domain.User;
import it.vscalcione.springboot.restapi.exceptions.EtAuthException;

public interface UserService {
    User validateUser (String email, String password) throws EtAuthException;
    User registerUser(String firstName, String lastName, String email, String password) throws EtAuthException;
}
