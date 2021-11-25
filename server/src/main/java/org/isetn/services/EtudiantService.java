package org.isetn.services;

import java.util.List;

import org.isetn.entities.Etudiant;

public interface EtudiantService {
    Etudiant saveEtudient(Etudiant etudiant);

    Etudiant updateEtudiant(Etudiant etudiant);

    void deleteEtudiantById(Long id);

    Etudiant getEtudiant(Long id);

    List<Etudiant> getAllEtudiants();
}
