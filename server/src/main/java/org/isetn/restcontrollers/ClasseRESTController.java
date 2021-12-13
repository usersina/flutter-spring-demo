package org.isetn.restcontrollers;

import java.util.List;

import org.isetn.entities.Classe;
import org.isetn.services.ClasseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/classes")
@CrossOrigin
public class ClasseRESTController {

    @Autowired
    ClasseService classeService;

    @RequestMapping(method = RequestMethod.POST)
    public Classe createClasse(@RequestBody Classe classe) {
        return classeService.saveClasse(classe);
    }

    @RequestMapping(method = RequestMethod.GET)
    public List<Classe> getAllClasses() {
        return classeService.getAllClasses();
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public Classe getClasseById(@PathVariable("id") Long id) {
        return classeService.getClasse(id);
    }

    @RequestMapping(method = RequestMethod.PUT)
    public Classe updateClasse(@RequestBody Classe etudiant) {
        return classeService.saveClasse(etudiant);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public void deleteClasse(@PathVariable("id") Long userId) {
        classeService.deleteClasseById(userId);
    }
}
