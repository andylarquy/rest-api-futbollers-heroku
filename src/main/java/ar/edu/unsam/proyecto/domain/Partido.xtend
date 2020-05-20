package ar.edu.unsam.proyecto.domain

import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsPartido
import com.fasterxml.jackson.annotation.JsonView
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Partido {

	@JsonView(ViewsPartido.ListView)
	String id

	@JsonView(ViewsPartido.DefaultView)
	Usuario owner

	@JsonView(ViewsPartido.ListView)
	Equipo equipo1

	@JsonView(ViewsPartido.ListView)
	Equipo equipo2

	@JsonView(ViewsPartido.DefaultView)
	Empresa empresa

	@JsonView(ViewsPartido.DetallesView)
	Cancha canchaReservada

	@JsonView(ViewsPartido.DetallesView)
	LocalDateTime fechaDeReserva

	def validar() {
		
		if (id === null){
			throw new Exception('El usuario debe tener un ID')
		}
		
		if (fechaDeReserva === null){
			throw new Exception('El usuario debe tener un ID')
		}
		
		equipo1.validar
		equipo2.validar
		owner.validar
		empresa.validar
		canchaReservada.validar
		validarLaFechaEstaDisponible()
	}
	
	//TODO: Hacer validarLaFechaEstaDisponible
	def validarLaFechaEstaDisponible(){
		
	}

	// TODO: Separar en equipo y equipo completo
	def participaUsuario(Usuario usuario) {
		usuario == owner || equipo1.participaUsuario(usuario) || equipo2.participaUsuario(usuario)
	}

}
