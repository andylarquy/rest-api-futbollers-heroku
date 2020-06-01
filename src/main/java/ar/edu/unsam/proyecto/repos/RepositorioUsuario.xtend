package ar.edu.unsam.proyecto.repos

import ar.edu.unsam.proyecto.domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import ar.edu.unsam.proyecto.exceptions.ObjectDoesntExists
import java.util.List
import javax.persistence.criteria.JoinType

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
	
	def coleccion(){
		
		queryTemplate(
			[criteria, query, from |
				from.fetch("partidos", JoinType.LEFT)
				return query
			], 
			[query | query.resultList]) as List<Usuario>
	}
	
	def existeUsuarioConMail(String email){
		coleccion.exists[usuario | usuario.tieneEsteMail(email)]
	}

	def searchById(Long idUsuario) {
		val usuario = coleccion.filter[usuario|usuario.getIdUsuario == idUsuario].head
		return (usuario !== null) ? usuario : throw new ObjectDoesntExists("No existe un usuario con el ID: "+idUsuario)
	}
	
	def getUsuarioConCredenciales(String email, String password){
	
	queryTemplate([criteria, query, from |

			query.where(
				criteria.equal(from.get("email"), email),
				criteria.equal(from.get("password"), password)
			)
		], [query | query.singleResult]) as Usuario
		
	}
	
	override entityType() {
		Usuario
	}
	
}