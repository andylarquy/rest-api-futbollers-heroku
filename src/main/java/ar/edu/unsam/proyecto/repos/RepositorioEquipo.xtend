package ar.edu.unsam.proyecto.repos

import ar.edu.unsam.proyecto.domain.Equipo
import ar.edu.unsam.proyecto.domain.Usuario
import ar.edu.unsam.proyecto.exceptions.ObjectAlreadyExists

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
			this.asignarIdPartido(equipo)
			this.create(equipo)
		}
	}

	def asignarIdPartido(Equipo equipo) {
		equipo.id = 'P' + idAutoincremental.toString
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
		val temp = coleccion.filter[it.participaUsuario(usuario)].toList

		println(temp)
		temp
	}
	
	def crearNuevoEquipo(Equipo equipo){
		println("ID!!: "+equipo.id)
		println("ID OWNER!!: "+equipo.owner.id)
		if(noExisteEquipoConId(equipo.id)){
			create(equipo)
		}else{
			throw new ObjectAlreadyExists("El equipo que se esta intentando agregar ya existe en el sistema")
		}
	}
	
	def noExisteEquipoConId(String idEquipo) {
		!coleccion.exists[it.id.equals(idEquipo)]
	}
	
}
