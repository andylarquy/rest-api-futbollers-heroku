package ar.edu.unsam.proyecto.domain

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@Entity
class Promocion {

	@Id @GeneratedValue
	Long idPromocion

	@Column()
	String codigo
	
	@Column()
	String descripcion
	
	@Column()
	int porcentajeDescuento

	def validar() {
		true
	}
}
