package ar.edu.unsam.proyecto.domain

import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsEmpresa
import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsEquipo
import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsPartido
import com.fasterxml.jackson.annotation.JsonView
import java.util.List
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
@Entity
class Empresa {
	
	
	@JsonView(ViewsEmpresa.DefaultView, ViewsEquipo.ListView, ViewsPartido.ListView)
	@Id @GeneratedValue
	Long idEmpresa
	
	@Column()
	@JsonView(ViewsEmpresa.DefaultView, ViewsEquipo.ListView, ViewsPartido.ListView) 
	String nombre

	//Revisar si tienen q estar
	@Column()
	@JsonView(ViewsEmpresa.DetallesView) 
	Double lat
	
	@Column()
	@JsonView(ViewsEmpresa.DetallesView) 
	Double lon
	
	@Column()
	@JsonView(ViewsEmpresa.DetallesView)
	String nombreDuenio
	
	@Column() 
	@JsonView(ViewsEmpresa.ListView, ViewsEmpresa.DetallesView) 
	String email
	
//	@Column()
	@JsonView(ViewsEmpresa.DetallesView) 
	transient Point lugar
	
	@Column()
	@JsonView(ViewsEmpresa.ListView, ViewsEquipo.ListView, ViewsEmpresa.DefaultView, ViewsPartido.ListView) 
	String direccion
	
	@Column()
	@JsonView(ViewsEmpresa.ListView, ViewsEmpresa.DefaultView, ViewsEquipo.ListView, ViewsPartido.ListView) 
	String foto
	
	@OneToMany
	@JsonView(ViewsEmpresa.DetallesView) 
	List<Cancha> canchas
	
	def agregarCancha(Cancha cancha){
		canchas.add(cancha)
	}
	
	def quitarCancha(Cancha cancha){
		canchas.remove(cancha)
	}
	
	//TODO: Esto
	def validar(){
		true
	}
	
	def tieneId(Long idBuscado) {
		idEmpresa.equals(idBuscado)
	}
	
	
}