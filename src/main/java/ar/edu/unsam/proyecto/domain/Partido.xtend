package ar.edu.unsam.proyecto.domain

import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsPartido
import com.fasterxml.jackson.annotation.JsonView
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import java.time.Period
import java.time.LocalDate
import java.time.Duration
import ar.edu.unsam.proyecto.exceptions.ObjectAlreadyExists

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
	
	@JsonView(ViewsPartido.DetallesView)
	Promocion promocion
	
	def precioTotal(){
		canchaReservada.precio * (1 - porcentajeDescuento / 100)
	}
	
	def porcentajeDescuento(){
		promocion !== null ? promocion.porcentajeDescuento : return 0
	}

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
	
	def validarFechaEstaLibre(LocalDateTime fecha) {
		if(sonLaMismaFecha(fechaDeReserva.toLocalDate, fecha.toLocalDate) && laDiferenciaEsMenorAUnaHora(fechaDeReserva, fecha)){
			throw new ObjectAlreadyExists('Ya existe una reserva para esa fecha y hora')
		} 
	}

	def sonLaMismaFecha(LocalDate fecha1, LocalDate fecha2){
		Period.between(fecha1, fecha2).days == 0
	}
	
	def laDiferenciaEsMenorAUnaHora(LocalDateTime fecha1, LocalDateTime fecha2){
		Math.abs(Duration.between(fecha1, fecha2).toMinutes) < 60
	}

}
