package ar.edu.unsam.proyecto.domain

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Cancha {
	
	int cantidadJugadores
	String id
	String foto
	String superficie

	def validar(){
		if (id === null){
			throw new Exception('La cancha debe tener un ID')
		} 
		
		if (foto === null){
			throw new Exception('La cancha debe tener una foto')
		}
		
		if (superficie === null){
			throw new Exception('La cancha debe tener un tipo de superficie')
		}  
		
		if (cantidadJugadores < 1){
			throw new Exception('La cantidad maxima de jugadores debe ser mayor a 1')
		}  
		
		if (cantidadJugadores % 2 != 0){
			throw new Exception('La cantidad maxima de jugadores debe ser par')
		}
		
	}
	
}