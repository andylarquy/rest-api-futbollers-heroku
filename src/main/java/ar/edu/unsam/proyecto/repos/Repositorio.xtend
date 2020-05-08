package ar.edu.unsam.proyecto.repos

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Repositorio <T>{
	List<T> coleccion = new ArrayList
	
	def create(T object){
		coleccion.add(object)
	}
	
	def delete(T object){
		coleccion.remove(object)
	}
	
}