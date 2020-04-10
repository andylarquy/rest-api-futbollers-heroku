package ar.edu.unsam.proyecto.domain

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Empresa {
	
	int id
	String nombre
	Double lat
	Double lon
	String nombreDuenio
	String email
	
	List<Cancha> canchas
	
	def agregarCancha(Cancha cancha){
		canchas.add(cancha)
	}
	
	def quitarCancha(Cancha cancha){
		canchas.remove(cancha)
	}
	
	
}