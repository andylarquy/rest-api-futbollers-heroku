package ar.edu.unsam.proyecto.domain

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Cancha {
	
	int cantidadJugadores
	String id
	String nombre
	String cesped

	//TODO: Esto
	def validar(){
		true
	}
	
}