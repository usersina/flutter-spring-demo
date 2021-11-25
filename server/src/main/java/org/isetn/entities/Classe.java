package org.isetn.entities;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.Collection;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Classe {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private String nom;

	private int nbEtudiant; // -- Should be inferred from array below

	@OneToMany(mappedBy = "classe")
	@JsonIgnore
	private Collection<Etudiant> etudiants;
}
