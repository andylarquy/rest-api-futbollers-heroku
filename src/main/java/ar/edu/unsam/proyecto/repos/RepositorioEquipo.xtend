package ar.edu.unsam.proyecto.repos

import ar.edu.unsam.proyecto.domain.Equipo
import ar.edu.unsam.proyecto.domain.Usuario

class RepositorioEquipo extends Repositorio<Equipo> {
	public static RepositorioEquipo repoEquipo

	static def RepositorioEquipo getInstance() {
		if (repoEquipo === null) {
			repoEquipo = new RepositorioEquipo()
		}
		repoEquipo
	}

	def reset() {
		repoEquipo = null
	}

	private new() {
	}



	def searchById(String equipoId) {
		return coleccion.filter[equipo|equipo.getIdEquipo.equals(equipoId)].head
	}

	def getEquiposDelUsuario(Usuario usuario) {
		coleccion.filter[it.participaUsuario(usuario)].toList
	}
	
	
	def noExisteEquipoConId(String idEquipo) {
		!coleccion.exists[it.getIdEquipo.equals(idEquipo)]
	}
	
	def searchEquipoById(String idBuscado){
		coleccion.filter[it.getIdEquipo.equals(idBuscado)].head
	}
	
	override entityType() {
		Equipo
	}
	
	
}
