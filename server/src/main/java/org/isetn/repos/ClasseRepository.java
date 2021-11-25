package org.isetn.repos;

import org.isetn.entities.Classe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource
public interface ClasseRepository extends JpaRepository<Classe, Long> {
}
