package ar.edu.unsam.proyecto.repos

import ar.edu.unsam.proyecto.domain.Cancha

class RepositorioCancha extends Repositorio<Cancha> {
	
	public static RepositorioCancha repoCancha

	static def RepositorioCancha getInstance() {
		if (repoCancha === null) {
			repoCancha = new RepositorioCancha()
		}
		repoCancha
	}

	def reset() {
		repoCancha = null
	}

	private new() {
	}

	int idAutoincremental = 1

	def createOrUpdate(Cancha cancha) {
		cancha.validar
		if (cancha.id !== null) {
			this.update(cancha)
		} else {
			this.asignarIdCancha(cancha)
			this.create(cancha)
		}
	}

	def asignarIdCancha(Cancha cancha) {
		cancha.id = 'P' + idAutoincremental.toString
		idAutoincremental++
	}

	def update(Cancha cancha) {

		// https://i.imgur.com/S6X48jx.png
		// searchById(superIndividuo.id).amigos = superIndividuo.amigos
		println("Tengo actualizar un partido... no se como hacerlo")
	}

	def searchById(String equipoId) {
		return coleccion.filter[equipo|equipo.id.equals(equipoId)].head
	}

	
	def noExisteCanchaConId(String idCancha) {
		!coleccion.exists[it.id.equals(idCancha)]
	}
	
	def searchEquipoById(String idBuscado){
		coleccion.filter[it.id.equals(idBuscado)].head
	}
	
}