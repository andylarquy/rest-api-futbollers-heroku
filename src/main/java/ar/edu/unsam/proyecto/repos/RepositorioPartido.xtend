package ar.edu.unsam.proyecto.repos

import ar.edu.unsam.proyecto.domain.Partido
import ar.edu.unsam.proyecto.domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.time.LocalDateTime

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
	
	def searchById(String cadenaId) {
		return coleccion.filter[partido|partido.getIdPartido.equals(cadenaId)].head
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