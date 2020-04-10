package ar.edu.unsam.proyecto.domain

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Equipo {
	
	int maximoDeIntegrantes
	String id
	String nombre
	
	Usuario owner

	List<Usuario> integrantes //Capaz conviene que sea un Set para no cagarla
	
	def agregarIntegrante(Usuario integrante){
		integrantes.add(integrante)
	}
	
	def quitarIntegrante(Usuario integrante){
		integrantes.remove(integrante)
	}
	
}