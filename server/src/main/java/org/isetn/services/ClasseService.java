package org.isetn.services;

import java.util.List;

import org.isetn.entities.Classe;

public interface ClasseService {
    Classe saveClasse(Classe classe);

    Classe updateClasse(Classe classe);

    void deleteClasseById(Long id);

    Classe getClasse(Long id);

    List<Classe> getAllClasses();
}
