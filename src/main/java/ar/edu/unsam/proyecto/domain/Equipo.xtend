package ar.edu.unsam.proyecto.domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Equipo {
	
	String id
	String nombre
	
	@JsonIgnore Usuario owner

	@JsonIgnore List<Usuario> integrantes //Capaz conviene que sea un Set para no cagarla
	
	def agregarIntegrante(Usuario integrante){
		integrantes.add(integrante)
	}
	
	def quitarIntegrante(Usuario integrante){
		integrantes.remove(integrante)
	}
	
	//TODO: Separar en equipo y equipo completo
	def contieneA(Usuario usuario) {
		owner == usuario || integrantes.contains(usuario)
	}
	
}