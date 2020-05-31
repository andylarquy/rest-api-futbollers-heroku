package ar.edu.unsam.proyecto.repos

import ar.edu.unsam.proyecto.domain.Equipo
import ar.edu.unsam.proyecto.domain.Usuario
import java.util.List
import javax.persistence.criteria.JoinType

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

	private new() {}
	
	def coleccion(){
		
		queryTemplate(
			[criteria, query, from |
				//from.fetch("owner", JoinType.LEFT)
				from.fetch("integrantes", JoinType.LEFT)
				return query
			], 
			[query | query.resultList]) as List<Equipo>
	}

	def searchById(Long equipoId) {
		return coleccion.filter[equipo|equipo.getIdEquipo == equipoId].head
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
