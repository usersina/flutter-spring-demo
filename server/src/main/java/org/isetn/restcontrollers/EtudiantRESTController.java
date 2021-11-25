package org.isetn.restcontrollers;

import java.util.List;

import org.isetn.entities.Etudiant;
import org.isetn.services.EtudiantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/etudiants")
@CrossOrigin
public class EtudiantRESTController {

    @Autowired
    EtudiantService etudiantService;

    @RequestMapping(method = RequestMethod.POST)
    public Etudiant createUser(@RequestBody Etudiant etudiant) {
        return etudiantService.saveEtudient(etudiant);
    }

    @RequestMapping(method = RequestMethod.GET)
    public List<Etudiant> getAllUsers() {
        return etudiantService.getAllEtudiants();
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public Etudiant getUserById(@PathVariable("id") Long id) {
        return etudiantService.getEtudiant(id);
    }

    @RequestMapping(method = RequestMethod.PUT)
    public Etudiant updateUser(@RequestBody Etudiant etudiant) {
        return etudiantService.saveEtudient(etudiant);
    }

    @RequestMapping(value = "/{userId}", method = RequestMethod.DELETE)
    public void deleteUser(@PathVariable("userId") Long userId) {
        etudiantService.deleteEtudiantById(userId);
    }

}
