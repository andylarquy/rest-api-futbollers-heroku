package ar.edu.unsam.proyecto.repos

import ar.edu.unsam.proyecto.domain.Partido
import ar.edu.unsam.proyecto.domain.Usuario
import java.time.LocalDateTime
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class RepositorioPartido extends Repositorio<Partido> {

	public static RepositorioPartido repoPartido

	static def RepositorioPartido getInstance() {
		if (repoPartido === null) {
			repoPartido = new RepositorioPartido()
		}
		repoPartido
	}

	def reset() {
		repoPartido = null
	}

	private new() {}
	
	def coleccion(){
		
		queryTemplate(
			[criteria, query, from |
				//from.fetch("equipo1", JoinType.LEFT)
				//from.fetch("equipo2", JoinType.LEFT)
				//from.fetch("empresa", JoinType.LEFT)
				//from.fetch("canchaReservada", JoinType.LEFT)
				//from.fetch("promocion", JoinType.LEFT)
				return query
			], 
			[query | query.resultList]) as List<Partido>
	}
	
	def searchById(Long idPartido) {
		return coleccion.filter[partido|partido.getIdPartido == idPartido].head
	}
	
	def getPartidosDelUsuario(Usuario usuario){
		coleccion.filter[it.participaUsuario(usuario)].toList
	}
	
	def validarFechaCancha(LocalDateTime fecha){
		coleccion.forEach[it.validarFechaEstaLibre(fecha)]
	}
	
	override entityType() {
		Partido
	}

	
	
}