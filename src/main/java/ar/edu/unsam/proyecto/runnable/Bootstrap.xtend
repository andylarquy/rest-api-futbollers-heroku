package ar.edu.unsam.proyecto.runnable

import ar.edu.unsam.proyecto.domain.Cancha
import ar.edu.unsam.proyecto.domain.Empresa
import ar.edu.unsam.proyecto.domain.Equipo
import ar.edu.unsam.proyecto.domain.Partido
import ar.edu.unsam.proyecto.domain.Usuario
import ar.edu.unsam.proyecto.repos.RepositorioCancha
import ar.edu.unsam.proyecto.repos.RepositorioEmpresa
import ar.edu.unsam.proyecto.repos.RepositorioEquipo
import ar.edu.unsam.proyecto.repos.RepositorioPartido
import ar.edu.unsam.proyecto.repos.RepositorioUsuario


import java.time.LocalDate
import java.time.LocalDateTime
import java.time.LocalTime

import io.github.cdimascio.dotenv.Dotenv
import ar.edu.unsam.proyecto.domain.Promocion
import ar.edu.unsam.proyecto.repos.RepositorioPromocion

class Bootstrap {

	public static Bootstrap bootstrap

	static def Bootstrap getInstance() {
		if (bootstrap === null) {
			bootstrap = new Bootstrap()
		}
		bootstrap
	}
	
	Dotenv dotenv = Dotenv.configure().ignoreIfMissing().load()

	private new() {}

	RepositorioUsuario repoUsuarios = RepositorioUsuario.instance
	RepositorioPartido repoPartido = RepositorioPartido.instance
	RepositorioEquipo repoEquipo = RepositorioEquipo.instance
	RepositorioEmpresa repoEmpresa = RepositorioEmpresa.instance
	RepositorioCancha repoCancha = RepositorioCancha.instance
	RepositorioPromocion repoPromocion = RepositorioPromocion.instance

	Usuario sebaCapo = new Usuario() => [
		id = "U1"
		nombre = "sebaCapo"
		password = dotenv.get("PASSWORD")
		sexo = "M"
		posicion = "DC"
		foto = "https://i.imgur.com/gF6Q26G.jpg"
		email = dotenv.get("EMAIL_SEBA")
		lat = -34.5677486
		lon = -58.489429
	]

	Usuario nikoBostero = new Usuario() => [
		id = "U2"
		nombre = "nikoBostero"
		password = dotenv.get("PASSWORD")
		sexo = "M"
		posicion = "ED"
		foto = "https://i.imgur.com/a0UL9YQ.png"
		email = dotenv.get("EMAIL_NIKO")
		lat = -34.6344499
		lon = -58.3672355
	]

	Usuario andy = new Usuario() => [
		id = "U3"
		nombre = "andy"
		password = dotenv.get("PASSWORD")
		sexo = "M"
		posicion = "DFI"
		foto = "https://i.imgur.com/tBUGRSa.jpg"
		email = dotenv.get("EMAIL_ANDY")
		lat = -34.6016244
		lon = -58.4420183
	]

	Usuario jugador1 = new Usuario() => [
		id = "U4"
		nombre = "Jugador 1"
		password = dotenv.get("PASSWORD")
		sexo = "M"
		posicion = "MC"
		foto = "https://i.imgur.com/DyYpkmS.jpg"
		email = "elmaildelnabo1@sarasa.com"
		lat = -34.6029831
		lon = -58.4408178
	]

	Usuario jugador2 = new Usuario() => [
		id = "U5"
		nombre = "Jugador 2"
		password = dotenv.get("PASSWORD")
		sexo = "F"
		posicion = "EI"
		foto = "https://i.imgur.com/AofDmoH.jpg"
		email = "elmaildelnabo2@sarasa.com"
		lat = -34.5768884
		lon = -58.4904551
	]

	Usuario jugador3 = new Usuario() => [
		id = "U6"
		nombre = "Jugador 3"
		password = dotenv.get("PASSWORD")
		sexo = "M"
		posicion = "MC"
		foto = "https://i.imgur.com/mUPUwOS.jpg"
		email = "elmaildelnabo3@sarasa.com"
		lat = -34.6029831
		lon = -58.4408178
	]

	Usuario jugador4 = new Usuario() => [
		id = "U7"
		nombre = "Jugador 4"
		password = dotenv.get("PASSWORD")
		sexo = "F"
		posicion = "EI"
		foto = "https://i.imgur.com/kzeiAar.jpg"
		email = "elmaildelnabo4@sarasa.com"
		lat = -34.5768884
		lon = -58.4904551
	]

	Equipo equipazo = new Equipo() => [
		id = "E1"
		nombre = "El equipazo"
		owner = sebaCapo
		foto = "https://i.imgur.com/hccT1z9.jpg"
		integrantes = #[sebaCapo, nikoBostero, andy, jugador1, jugador2]
	]

	Equipo equipoMalo = new Equipo() => [
		id = "E2"
		nombre = "El equipo malo"
		owner = andy
		foto = "https://i.imgur.com/RhqYpUg.jpg"
		integrantes = #[jugador1, jugador2, jugador3, jugador4, andy]
	]

	Equipo equipoIncompleto = new Equipo() => [
		id = "E3"
		nombre = "Equipo incompleto"
		owner = nikoBostero
		foto="https://i.imgur.com/lvR3nt3.jpg"
		integrantes = #[sebaCapo, nikoBostero, andy]
	]

	Cancha urquiza1 = new Cancha() => [
		id = "C1"
		foto = "https://i.imgur.com/jrziFQc.png"
		setSuperficie = "sintetico"
		cantidadJugadores = 10
		precio = 2000.0
	]

	Cancha urquiza2 = new Cancha() => [
		id = "C2"
		foto = "https://i.imgur.com/iUBWJAL.jpg"
		setSuperficie = "sintetico"
		cantidadJugadores = 10
		precio = 2000.0
	]

	Cancha vicLop1 = new Cancha() => [
		id = "C3"
		foto = "https://i.imgur.com/J29IXSA.png"
		setSuperficie = "sintetico"
		cantidadJugadores = 10
		precio = 1500.0
	]

	Cancha vicLop2 = new Cancha() => [
		id = "C4"
		foto = "https://i.imgur.com/OO24aMM.jpg"
		setSuperficie = "sintetico"
		cantidadJugadores = 10
		precio = 1500.0
	]

	Cancha vicLop3 = new Cancha() => [
		id = "C5"
		foto = "https://i.imgur.com/k14oJiW.jpg"
		setSuperficie = "cemento"
		cantidadJugadores = 14
		precio = 2100.0
	]

	Cancha argen1 = new Cancha() => [
		id = "C6"
		foto = "https://i.imgur.com/1eIVVny.jpg"
		setSuperficie = "sintetico"
		cantidadJugadores = 8
		precio = 1800.0
	]

	Cancha argen2 = new Cancha() => [
		id = "C7"
		foto = "https://i.imgur.com/2yZN1T5.jpg"
		setSuperficie = "sintetico"
		cantidadJugadores = 12
		precio = 2500.0
	]

	Empresa empresaUrquiza = new Empresa => [
		id = "E1"
		nombre = "Futbol Urquiza"
		lat = -34.5748777
		lon = -58.4903939
		canchas = #[urquiza1, urquiza2]
		nombreDuenio = "Tito Bara"
		email = "futbolUrquiza@gmail.com"
		direccion = "Roosevelt 5110"
		foto = "https://i.imgur.com/uBq4qBV.jpg"
	]

	Empresa empresaVicenteLopez = new Empresa => [
		id = "E2"
		nombre = "Futbol Mitre"
		lat = -34.5141931
		lon = -58.5315329
		canchas = #[vicLop1, vicLop2, vicLop3]
		nombreDuenio = "Jorge"
		email = "miraSiVaATenerMail@dePedoTieneAgua.com"
		direccion = "Mitre 3847"
		foto = "https://i.imgur.com/9QfoGNr.png"
	]

	Empresa empresaArgentinos = new Empresa => [
		id = "E3"
		nombre = "Argentinos :)"
		lat = -34.6078057
		lon = -58.4763221
		canchas = #[argen1, argen2]
		nombreDuenio = "No se mi nombre"
		email = "niIdea@noSe.com"
		direccion = "Sarasa 123"
		foto = "https://i.imgur.com/RUOAmuX.png"
	]

	Partido partido1 = new Partido() => [
		id = "P1"
		owner = sebaCapo
		equipo1 = equipazo
		equipo2 = equipoMalo
		empresa = empresaUrquiza
		canchaReservada = urquiza1
		fechaDeReserva = LocalDateTime.of(LocalDate.of(2020, 12, 25), LocalTime.of(20, 00))
	]

	Partido partido2 = new Partido() => [
		id = "P2"
		owner = andy
		equipo1 = equipazo
		equipo2 = equipoIncompleto
		empresa = empresaVicenteLopez
		canchaReservada = vicLop2
		fechaDeReserva = LocalDateTime.of(LocalDate.of(2020, 4, 24), LocalTime.of(17, 00))
	]

	Promocion promo1 = new Promocion() => [
		idPromocion = "P1"
		codigo = "cocacola"
		descripcion = "Con Coca-Cola te hacemos el aguante!"
		porcentajeDescuento = 25
	]
	
	Promocion promo2 = new Promocion() => [
		idPromocion = "P2"
		codigo = "asd"
		descripcion = "Esta promo es una prueba"
		porcentajeDescuento = 50
	]
	
	Promocion promo3 = new Promocion() => [
		idPromocion = "P3"
		codigo = "nike"
		descripcion = "Just Do It"
		porcentajeDescuento = 15
	]

	def runBootstrap() {
		
		//Es para suprimir el warning nomas
		empresaArgentinos = empresaArgentinos
		
		repoUsuarios.create(sebaCapo)
		repoUsuarios.create(nikoBostero)
		repoUsuarios.create(andy)
		repoUsuarios.create(jugador1)
		repoUsuarios.create(jugador2)
		repoUsuarios.create(jugador3)
		repoUsuarios.create(jugador4)

		repoEquipo.crearNuevoEquipo(equipazo)
		repoEquipo.crearNuevoEquipo(equipoMalo)
		repoEquipo.crearNuevoEquipo(equipoIncompleto)
		
		repoCancha.create(urquiza1)
		repoCancha.create(urquiza2)
		repoCancha.create(vicLop1)
		repoCancha.create(vicLop2)
		repoCancha.create(vicLop3)
		repoCancha.create(argen1)
		repoCancha.create(argen2)

		repoEmpresa.create(empresaUrquiza)
		repoEmpresa.create(empresaVicenteLopez)
		repoEmpresa.create(empresaArgentinos)
		
		repoPartido.crearNuevoPartido(partido1)
		repoPartido.crearNuevoPartido(partido2)
		
		repoPromocion.create(promo1)
		repoPromocion.create(promo2)
		repoPromocion.create(promo3)

	}

}
