package org.isetn.services;

import java.util.List;

import org.isetn.entities.Classe;
import org.isetn.repos.ClasseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClasseServiceImpl implements ClasseService {

    @Autowired
    ClasseRepository classeRepository;

    @Override
    public Classe saveClasse(Classe classe) {
        return classeRepository.save(classe);
    }

    @Override
    public Classe updateClasse(Classe classe) {
        return classeRepository.save(classe);
    }

    @Override
    public void deleteClasseById(Long id) {
        classeRepository.deleteById(id);
    }

    @Override
    public Classe getClasse(Long id) {
        return classeRepository.findById(id).get();
    }

    @Override
    public List<Classe> getAllClasses() {
        return classeRepository.findAll();
    }

}
