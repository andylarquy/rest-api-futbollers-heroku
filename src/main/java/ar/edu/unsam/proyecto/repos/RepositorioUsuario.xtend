package ar.edu.unsam.proyecto.repos

import ar.edu.unsam.proyecto.domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import ar.edu.unsam.proyecto.exceptions.ObjectDoesntExists

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
	
	
	def existeUsuarioConMail(String email){
		
		coleccion.exists[usuario | usuario.tieneEsteMail(email)]
		
	}


	def searchById(Long cadenaId) {
		val usuario = coleccion.filter[usuario|usuario.getIdUsuario == cadenaId].head
		return (usuario !== null) ? usuario : throw new ObjectDoesntExists("No existe un usuario con el ID: "+cadenaId)
	}
	
	def getUsuarioConCredenciales(String username, String password){
		coleccion.filter[usuario | usuario.tieneCredenciales(username, password)].head
	}
	
	override entityType() {
		Usuario
	}
	
	

	
}