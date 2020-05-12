package ar.edu.unsam.proyecto.repos

import ar.edu.unsam.proyecto.domain.Partido
import ar.edu.unsam.proyecto.domain.Usuario
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
	
	int idAutoincremental = 1

	def createOrUpdate(Partido partido) {
		partido.validar
		if (partido.id !== null) {
			this.update(partido)
		} else {
			this.asignarIdPartido(partido)
			this.create(partido)
		}
	}

	def asignarIdPartido(Partido partido) {
		partido.id = 'P' + idAutoincremental.toString
		idAutoincremental++
	}

	def update(Partido partido) {
		
		//https://i.imgur.com/S6X48jx.png
		
		//searchById(superIndividuo.id).amigos = superIndividuo.amigos
		println("Tengo actualizar un partido... no se como hacerlo")
	}
	
	def crearNuevoPartido(Partido partido){
		this.asignarIdPartido(partido)
		create(partido)
		println("[DEBUG]: Se ha creado un nuevo partido con ID: "+partido.id+"\n")
	}

	def searchById(String cadenaId) {
		return coleccion.filter[partido|partido.id.equals(cadenaId)].head
	}
	
	def getPartidosDelUsuario(Usuario usuario){
		coleccion.filter[it.participaUsuario(usuario)].toList
		
	}
	
	
}