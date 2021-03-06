package ar.edu.unsam.proyecto.domain

import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsCancha
import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsEmpresa
import com.fasterxml.jackson.annotation.JsonView
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@Entity
class Cancha {
	
	@Id @GeneratedValue
	@JsonView(ViewsEmpresa.SetupView, ViewsCancha.DefaultView)
	Long idCancha
	
	@Column()
	@JsonView(ViewsCancha.DefaultView)
	int cantidadJugadores
	
	@Column()
	@JsonView(ViewsCancha.DefaultView)
	String foto
	
	@Column()
	@JsonView(ViewsCancha.DefaultView)
	String superficie
	
	@Column()
	@JsonView(ViewsCancha.DefaultView)
	Double precio

	def validar(){
		if (idCancha === null){
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