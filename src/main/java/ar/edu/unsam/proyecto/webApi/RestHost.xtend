package ar.edu.unsam.proyecto.webApi

import ar.edu.unsam.proyecto.domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RestHost {
	/*RepositorioEquipo repoEquipo
	RepositorioSuperIndividuo repoIndividuo
	RepositorioItem repoItem
	RepositorioAmenaza repoAmenaza*/

	def getPeticionDePrueba() {
		return "La API Rest esta funcionando!! :)"
	}

}
