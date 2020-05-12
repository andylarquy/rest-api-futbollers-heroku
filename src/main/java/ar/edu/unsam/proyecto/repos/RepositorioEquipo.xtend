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

	int idAutoincremental = 1

	def createOrUpdate(Equipo equipo) {
		equipo.validar
		if (equipo.id !== null) {
			this.update(equipo)
		} else {
			this.asignarIdEquipo(equipo)
			this.create(equipo)
		}
	}

	def asignarIdEquipo(Equipo equipo) {
		equipo.id = 'E' + idAutoincremental.toString
		idAutoincremental++
	}

	def update(Equipo equipo) {

		// https://i.imgur.com/S6X48jx.png
		// searchById(superIndividuo.id).amigos = superIndividuo.amigos
		println("Tengo actualizar un partido... no se como hacerlo")
	}

	def searchById(String equipoId) {
		return coleccion.filter[equipo|equipo.id.equals(equipoId)].head
	}

	def getEquiposDelUsuario(Usuario usuario) {
		coleccion.filter[it.participaUsuario(usuario)].toList
	}
	
	def crearNuevoEquipo(Equipo equipo){
			this.asignarIdEquipo(equipo)
			create(equipo)
			println("[DEBUG]: Se ha creado un nuevo equipo con ID: "+equipo.id+"\n")
	}
	
	def noExisteEquipoConId(String idEquipo) {
		!coleccion.exists[it.id.equals(idEquipo)]
	}
	
	def searchEquipoById(String idBuscado){
		coleccion.filter[it.id.equals(idBuscado)].head
	}
	
}
