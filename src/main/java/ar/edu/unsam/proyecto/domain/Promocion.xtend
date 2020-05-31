package ar.edu.unsam.proyecto.domain

import com.fasterxml.jackson.annotation.JsonIgnore
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Promocion {
	
	String idPromocion
	String codigo
	String descripcion
	int porcentajeDescuento
	
	def validar(){
		true
	}
}