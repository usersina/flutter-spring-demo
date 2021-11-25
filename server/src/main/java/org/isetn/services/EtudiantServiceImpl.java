package org.isetn.services;

import java.util.List;

import org.isetn.entities.Etudiant;
import org.isetn.repos.EtudiantRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EtudiantServiceImpl implements EtudiantService {

    @Autowired
    EtudiantRepository etudiantRepository;

    @Override
    public Etudiant saveEtudient(Etudiant etudiant) {
        return etudiantRepository.save(etudiant);
    }

    @Override
    public Etudiant updateEtudiant(Etudiant etudiant) {
        return etudiantRepository.save(etudiant);
    }

    @Override
    public void deleteEtudiantById(Long id) {
        etudiantRepository.deleteById(id);
    }

    @Override
    public Etudiant getEtudiant(Long id) {
        return etudiantRepository.findById(id).get();
    }

    @Override
    public List<Etudiant> getAllEtudiants() {
        return etudiantRepository.findAll();
    }

}
