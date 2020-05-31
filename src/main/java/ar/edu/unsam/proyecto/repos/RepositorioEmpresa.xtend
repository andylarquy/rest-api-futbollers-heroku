package ar.edu.unsam.proyecto.repos

import ar.edu.unsam.proyecto.domain.Empresa
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unsam.proyecto.exceptions.ObjectDoesntExists

@Accessors
class RepositorioEmpresa extends Repositorio<Empresa> {

	public static RepositorioEmpresa repoEmpresa

	static def RepositorioEmpresa getInstance() {
		if (repoEmpresa === null) {
			repoEmpresa = new RepositorioEmpresa()
		}
		repoEmpresa
	}

	def reset() {
		repoEmpresa = null
	}

	private new() {
	}

	def searchById(Long cadenaId) {
		return coleccion.filter[empresa|empresa.getIdEmpresa == cadenaId].head
	}

	def getEmpresaById(Long idEmpresa) {
		val empresaBuscada = coleccion.findFirst[it.tieneId(idEmpresa)]

		if (empresaBuscada === null) {
			throw new ObjectDoesntExists('No existe una empresa con ese ID')
		}

		return empresaBuscada
	}

	override entityType() {
		Empresa
	}

}
