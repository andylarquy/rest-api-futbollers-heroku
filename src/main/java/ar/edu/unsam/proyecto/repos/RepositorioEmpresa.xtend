package ar.edu.unsam.proyecto.repos

import ar.edu.unsam.proyecto.domain.Empresa
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RepositorioEmpresa extends Repositorio<Empresa>  {

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

	private new() {}
	
	int idAutoincremental = 1

	def createOrUpdate(Empresa empresa) {
		empresa.validar
		if (empresa.id !== null) {
			this.update(empresa)
		} else {
			this.asignarIdEmpresa(empresa)
			this.create(empresa)
		}
	}

	def asignarIdEmpresa(Empresa empresa) {
		empresa.id = 'E' + idAutoincremental.toString
		idAutoincremental++
	}

	def update(Empresa empresa) {
		
		//https://i.imgur.com/S6X48jx.png
		
		//searchById(superIndividuo.id).amigos = superIndividuo.amigos
		println("Tengo actualizar un partido... no se como hacerlo")
	}

	def searchById(String cadenaId) {
		return coleccion.filter[empresa|empresa.id.equals(cadenaId)].head
	}
	
	
}
