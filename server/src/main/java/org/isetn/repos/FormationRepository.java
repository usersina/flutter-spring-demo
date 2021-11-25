package org.isetn.repos;

import org.isetn.entities.Formation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource
public interface FormationRepository extends JpaRepository<Formation, Long> {
}
