package ar.edu.unsam.proyecto.repos

import ar.edu.unsam.proyecto.domain.Promocion

class RepositorioPromocion extends Repositorio<Promocion> {
	
	public static RepositorioPromocion repoPromocion

	static def RepositorioPromocion getInstance() {
		if (repoPromocion === null) {
			repoPromocion = new RepositorioPromocion()
		}
		repoPromocion
	}
	
	def reset() {
		repoPromocion = null
	}
	
	private new() {}
	
	int idAutoincremental = 1

	def createOrUpdate(Promocion promocion) {
		promocion.validar
		if (promocion.idPromocion !== null) {
			this.update(promocion)
		} else {
			this.asignarIdPromocion(promocion)
			this.create(promocion)
		}
	}

	def asignarIdPromocion(Promocion promocion) {
		promocion.idPromocion = 'P' + idAutoincremental.toString
		idAutoincremental++
	}

	def update(Promocion promocion) {

		// https://i.imgur.com/S6X48jx.png
		// searchById(superIndividuo.id).amigos = superIndividuo.amigos
		println("Tengo actualizar un partido... no se como hacerlo")
	}

	def searchById(String promocionId) {
		return coleccion.filter[promocion | promocion.idPromocion.equals(promocionId)].head
	}
	
	def searchByCodigo(String codigo) {
		return coleccion.filter[promocion | promocion.codigo.equals(codigo)].head
	}
	
}