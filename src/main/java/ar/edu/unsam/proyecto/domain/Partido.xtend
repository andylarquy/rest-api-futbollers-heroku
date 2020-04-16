package ar.edu.unsam.proyecto.domain

import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsPartido
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonView
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.core.JsonGenerator
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
class Partido {
	
	@JsonView(ViewsPartido.DefaultView) String id
	
	@JsonIgnore Usuario owner
	
	@JsonView(ViewsPartido.DefaultView) Equipo equipo1
	@JsonView(ViewsPartido.DefaultView) Equipo equipo2
	
	Empresa empresa
	@JsonIgnore Cancha canchaReservada
	@JsonIgnore LocalDateTime fechaDeReserva
	
	
	
	def validar(){
		true
	}

	
	
	//TODO: Separar en equipo y equipo completo
	def participaUsuario(Usuario usuario) {
		usuario == owner || equipo1.contieneA(usuario) || equipo2.contieneA(usuario)
	}
	
}