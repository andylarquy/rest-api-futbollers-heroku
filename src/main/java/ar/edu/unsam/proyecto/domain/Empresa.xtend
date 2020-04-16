package ar.edu.unsam.proyecto.domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Empresa {
	
	String id
	String nombre
	
	//Revisar si tienen q estar
	@JsonIgnore Double lat
	@JsonIgnore Double lon
	@JsonIgnore String nombreDuenio
	@JsonIgnore String email
	@JsonIgnore Point lugar
	String direccion
	String foto
	
	@JsonIgnore List<Cancha> canchas
	
	def agregarCancha(Cancha cancha){
		canchas.add(cancha)
	}
	
	def quitarCancha(Cancha cancha){
		canchas.remove(cancha)
	}
	
	
}