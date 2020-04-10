package ar.edu.unsam.proyecto.runnable

import ar.edu.unsam.proyecto.domain.Cancha
import ar.edu.unsam.proyecto.domain.Equipo
import ar.edu.unsam.proyecto.domain.Usuario
import ar.edu.unsam.proyecto.repos.RepositorioUsuario

class Bootstrap {
	
	public static Bootstrap bootstrap

	static def Bootstrap getInstance() {
		if (bootstrap === null) {
			bootstrap = new Bootstrap()
		}
		bootstrap
	}

	private new() {}
	
	RepositorioUsuario repoUsuarios = RepositorioUsuario.instance
	
	Usuario sebaCapo = new Usuario() => [
		id = "U1"
		nombre = "sebaCapo"
		password = "mandarina"
		sexo = "M"
		posicion = "DC"
		email = "sebassdevita@gmail.com"
		lat = -34.5677486
		lon = -58.489429
	]
	
	Usuario nikoBostero = new Usuario() => [
		id = "U2"
		nombre = "nikoBostero"
		password = "mandarina"
		sexo = "M"
		posicion = "ED"
		email = "niko.bostero.232@gmail.com"
		lat = -34.6344499
		lon = -58.3672355
	]
	
	Usuario andy = new Usuario() => [
		id = "U3"
		nombre = "andy"
		password = "mandarina"
		sexo = "M"
		posicion = "DFI"
		email = "andres27059934@gmail.com"
		lat = -34.6016244
		lon = -58.4420183
	]
	
	Usuario nabo1 = new Usuario() => [
		id = "U4"
		nombre = "nabo1"
		password = "mandarina"
		sexo = "M"
		posicion = "MC"
		email = "elmaildelnabo1@sarasa.com"
		lat = -34.6029831
		lon = -58.4408178
	]
	
	Usuario nabo2 = new Usuario() => [
		id = "U5"
		nombre = "nabo2"
		password = "mandarina"
		sexo = "F"
		posicion = "EI"
		email = "elmaildelnabo2@sarasa.com"
		lat = -34.5768884
		lon = -58.4904551
	]
	
	Equipo equipazo = new Equipo() =>[
		id = "E1"
		nombre = "El equipazo"
		owner = sebaCapo
		integrantes = #[sebaCapo, nikoBostero, andy ,nabo1, nabo2]
		maximoDeIntegrantes = 5
	]
	
	Equipo equipoIncompleto = new Equipo() =>[
		id = "E2"
		nombre = "Equipo incompleto"
		owner = nikoBostero
		integrantes = #[sebaCapo, nikoBostero, andy]
		maximoDeIntegrantes = 6
	]
	
	Cancha urquiza1 = new Cancha() =>[
		id = "C1"
		nombre = "Cancha 1 Urquiza"
		cesped = "sintetico"
		cantidadJugadores = 10
	]
	
	Cancha urquiza2 = new Cancha() =>[
		id = "C2"
		nombre = "Cancha 2 Urquiza"
		cesped = "sintetico"
		cantidadJugadores = 10
	]
	
	Cancha vicLop1 = new Cancha() =>[
		id = "C3"
		nombre = "Cancha chica 1 Vic Lop"
		cesped = "sintetico"
		cantidadJugadores = 10
	]
	
	Cancha vicLop2 = new Cancha() =>[
		id = "C4"
		nombre = "Cancha chica 2 Vic Lop"
		cesped = "sintetico"
		cantidadJugadores = 10
	]
	
	Cancha vicLop3 = new Cancha() =>[
		id = "C5"
		nombre = "Cancha grande Vic Lop"
		cesped = "cemento"
		cantidadJugadores = 14
	]
	
	Cancha argen1 = new Cancha() =>[
		id = "C6"
		nombre = "Cancha Chica Argentinos"
		cesped = "cemento"
		cantidadJugadores = 8
	]
	
	Cancha argen2 = new Cancha() =>[
		id = "C7"
		nombre = "Cancha Grande Argentinos"
		cesped = "cemento"
		cantidadJugadores = 12
	]
	
	def runBootstrap(){
		repoUsuarios.create(sebaCapo)
		repoUsuarios.create(nikoBostero)
		repoUsuarios.create(andy)
		repoUsuarios.create(nabo1)
		repoUsuarios.create(nabo2)
	}
	
}