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
import ar.edu.unsam.proyecto.repos.RepositorioEmpresa
import ar.edu.unsam.proyecto.repos.RepositorioPromocion
import ar.edu.unsam.proyecto.exceptions.ObjectDoesntExists
import java.time.LocalDateTime
import javax.persistence.NoResultException

@Accessors
class RestHost {
	RepositorioUsuario repoUsuario = RepositorioUsuario.instance
	RepositorioEquipo repoEquipo = RepositorioEquipo.instance
	RepositorioPartido repoPartido = RepositorioPartido.instance
	RepositorioCancha repoCancha = RepositorioCancha.instance
	RepositorioEmpresa repoEmpresa = RepositorioEmpresa.instance
	RepositorioPromocion repoPromociones = RepositorioPromocion.instance
	
	def getPeticionDePrueba() {
		return '{ "message": "La API Rest esta funcionando!! :)" }'
	}
	
	def loguearUsuario(String email, String password){
		try{			
			return repoUsuario.getUsuarioConCredenciales(email, password)
		}catch(NoResultException e){
			throw new IncorrectCredentials("Credenciales Invalidas")
		}
	}
	
	def signUpUsuario(Usuario usuario) {

		if (!repoUsuario.existeUsuarioConMail(usuario.email)){
				repoUsuario.create(usuario)
		} else {
				throw new IncorrectCredentials("Este mail ya pertenece a un usuario")
		}
	}
	
	def getPartidosDelUsuario(Long idUsuario) {
		val usuarioPosta = repoUsuario.searchById(idUsuario)
		usuarioPosta.partidos
	}
	
	def getEquiposDelUsuario(Long idUsuario) {
		val usuarioPosta = repoUsuario.searchById(idUsuario)
		repoEquipo.getEquiposDelUsuario(usuarioPosta)
	}
	
	def crearNuevoEquipo(Equipo equipo) {
		equipo.validar()
		repoEquipo.create(equipo)
	}
	
	def crearNuevoPartido(Partido partido, Long idUsuario) {
		val usuarioPosta = repoUsuario.searchById(idUsuario)
		partido.validar()
		repoPartido.create(partido)
		usuarioPosta.agregarPartido(partido)
	}
	
	def getCanchas(){
		repoCancha.coleccion
	}
	
	def getEmpresas(){
		repoEmpresa.coleccion
	}
	
	///////////////////////////////////
	//ESTO PARECE QUE ESTA REPETIDO...
	//https://i.imgur.com/gokGIGk.jpg
	
	def getEmpresaById(Long idEmpresa){
		repoEmpresa.getEmpresaById(idEmpresa)
	}
	
	def getCanchasDeLaEmpresaById(Long idEmpresa){
		getEmpresaById(idEmpresa).canchas
	}	
	//////////////////////////////////
	
	def getPromocionByCodigo(String codigo){
		
		val promocion = repoPromociones.searchByCodigo(codigo)
		promocion !== null ? return promocion : throw new ObjectDoesntExists('No existe ese codigo promocional')	
	}
	
	def validarFechaCancha(LocalDateTime fecha){
		repoPartido.validarFechaCancha(fecha)
	}
	
	def getAmigosDelUsuario(Long idUsuario) {
		repoUsuario.getAmigosDelUsuario(idUsuario)
	}

}
