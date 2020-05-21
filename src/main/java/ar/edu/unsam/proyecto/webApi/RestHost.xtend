package ar.edu.unsam.proyecto.webApi

import ar.edu.unsam.proyecto.domain.Equipo
import ar.edu.unsam.proyecto.domain.Partido
import ar.edu.unsam.proyecto.domain.Usuario
import ar.edu.unsam.proyecto.exceptions.IncorrectCredentials
import ar.edu.unsam.proyecto.repos.RepositorioCancha
import ar.edu.unsam.proyecto.repos.RepositorioEquipo
import ar.edu.unsam.proyecto.repos.RepositorioPartido
import ar.edu.unsam.proyecto.repos.RepositorioUsuario
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RestHost {
	RepositorioUsuario repoUsuario = RepositorioUsuario.instance
	//TODO Revisar doble repopartido y repopartidos
	RepositorioPartido repoPartidos = RepositorioPartido.instance
	RepositorioEquipo repoEquipo = RepositorioEquipo.instance
	RepositorioPartido repoPartido = RepositorioPartido.instance
	RepositorioCancha repoCanchas = RepositorioCancha.instance
	
	def getPeticionDePrueba() {
		return '{ "message": "La API Rest esta funcionando!! :)" }'
	}
	
	def loguearUsuario(String email, String password){
		val usuario = repoUsuario.getUsuarioConCredenciales(email, password)
		usuario === null ? throw new IncorrectCredentials("Credenciales Invalidas") : return usuario
	}
	
	def signUpUsuario(Usuario usuario) {

		if (!repoUsuario.existeUsuarioConMail(usuario.email)){

				repoUsuario.create(usuario)
		} else {

				throw new IncorrectCredentials("Este mail ya pertenece a un usuario")
		}

	}
	
	def getPartidosDelUsuario(String idUsuario) {
		val usuarioPosta = repoUsuario.searchById(idUsuario)
		repoPartidos.getPartidosDelUsuario(usuarioPosta)

	}
	
	def getEquiposDelUsuario(String idUsuario) {
		val usuarioPosta = repoUsuario.searchById(idUsuario)
		repoEquipo.getEquiposDelUsuario(usuarioPosta)
	}
	
	def crearNuevoEquipo(Equipo equipo) {
		repoEquipo.crearNuevoEquipo(equipo)
	}
	
	def crearNuevoPartido(Partido partido) {
		repoPartido.crearNuevoPartido(partido)
	}
	
	def getCanchas(){
		repoCanchas.coleccion
	}

}
