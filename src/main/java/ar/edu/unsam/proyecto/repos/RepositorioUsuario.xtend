package ar.edu.unsam.proyecto.repos

import ar.edu.unsam.proyecto.domain.Usuario
import java.time.LocalDate
import java.time.Period
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.util.Set

@Observable
@Accessors
class RepositorioUsuario extends Repositorio<Usuario> {

	public static RepositorioUsuario repoUsuario

	static def RepositorioUsuario getInstance() {
		if (repoUsuario === null) {
			repoUsuario = new RepositorioUsuario()
		}
		repoUsuario
	}

	def reset() {
		repoUsuario = null
	}

	private new() {}
	
	int idAutoincremental = 1

	def createOrUpdate(Usuario usuario) {
		usuario.validar
		if (usuario.id !== null) {
			this.update(usuario)
		} else {
			this.asignarIdUsuario(usuario)
			this.create(usuario)
		}
	}
	
	def existeUsuarioConMail(String email){
		
		coleccion.exists[usuario | usuario.tieneEsteMail(email)]
		
	}

	def asignarIdUsuario(Usuario usuario) {
		usuario.id = 'U' + idAutoincremental.toString
		idAutoincremental++
	}

	def update(Usuario usuario) {
		
		//https://i.imgur.com/S6X48jx.png
		
		//searchById(superIndividuo.id).amigos = superIndividuo.amigos
		println("Tengo actualizar un usuario... no se como hacerlo")
	}

	def searchById(String cadenaId) {
		return coleccion.filter[usuario|usuario.id == cadenaId].head
	}
	
	def getUsuarioConCredenciales(String username, String password){
		coleccion.filter[usuario | usuario.tieneCredenciales(username, password)].head
	}

	
}