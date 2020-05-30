package ar.edu.unsam.proyecto.domain

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsEmpresa
import com.fasterxml.jackson.annotation.JsonView
import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsCancha

@Accessors
class Cancha {
	
	@JsonView(ViewsEmpresa.SetupView, ViewsCancha.DefaultView)
	String id
	
	@JsonView(ViewsCancha.DefaultView)
	int cantidadJugadores
	
	@JsonView(ViewsCancha.DefaultView)
	String foto
	
	@JsonView(ViewsCancha.DefaultView)
	String superficie
	
	@JsonView(ViewsCancha.DefaultView)
	Double precio

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