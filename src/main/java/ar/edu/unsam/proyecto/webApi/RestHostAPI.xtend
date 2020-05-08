package ar.edu.unsam.proyecto.webApi

import ar.edu.unsam.proyecto.domain.Equipo
import ar.edu.unsam.proyecto.domain.Usuario
import ar.edu.unsam.proyecto.exceptions.IncorrectCredentials
import ar.edu.unsam.proyecto.exceptions.ObjectAlreadyExists
import ar.edu.unsam.proyecto.exceptions.UserDoesntExist
import ar.edu.unsam.proyecto.repos.RepositorioUsuario
import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsEquipo
import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsPartido
import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsUsuario
import com.fasterxml.jackson.databind.MapperFeature
import com.fasterxml.jackson.databind.ObjectMapper
import org.json.JSONObject
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.json.JSONUtils
import com.google.gson.Gson
import org.json.JSONArray

@Controller
class RestHostAPI {
	extension JSONUtils = new JSONUtils
	RestHost restHost
	
	RepositorioUsuario repoUsuario = RepositorioUsuario.instance

	new(RestHost restHost) {
		this.restHost = restHost
	}

	@Get("/index")
	def getPeticionDePrueba() {

		try{
			ok(restHost.getPeticionDePrueba())
		}
		catch(Exception e){
			badRequest('{"status":400, "message":"' + e.message + '"}')
		}
	}

	@Post("/usuario/login")
	def loguearUsuario(@Body String body) {

		val Usuario usuario = body.fromJson(Usuario)
		// println(usuario.email)
		try {
			val usuarioParseado = this.parsearObjeto(restHost.loguearUsuario(usuario.email, usuario.password),
				ViewsUsuario.CredencialesView)

			// println("Json del usuario recien logueado: " + usuarioParseado + "\n")
			ok(usuarioParseado)
		} 
		catch (IncorrectCredentials e) {
			forbidden('{"status":401, "message":"' + e.message + '"}')
		}
		catch (Exception e) {
			badRequest('{"status":400, "message":"' + e.message + '"}')
		}
	}

	@Post("/usuario")
	def signUpUsuario(@Body String body) {

		val Usuario usuario = body.fromJson(Usuario)

		println(body)
		try {
			restHost.signUpUsuario(usuario)
			ok('{"status": 200}')
		} 
		catch (IncorrectCredentials e) {
			badRequest('{"status":400, "message":"' + e.message + '"}')
		} 
		catch (Exception e) {
			badRequest('{"status":400, "message":"' + e.message + '"}')
		}
	}

	@Get("/partidos/:idUsuario")
	def getPartidos() {

		try {
			println(restHost.getPartidosDelUsuario(idUsuario).map[it.equipo1].map[nombre])
			var partidoParseado = this.parsearObjeto(restHost.getPartidosDelUsuario(idUsuario),
				ViewsPartido.ListView)
			ok(partidoParseado)	
		} 
		catch (UserDoesntExist e) {
			notFound('{"status":404, "message":"' + e.message + '"}')
		} 
		catch (Exception e) {
			badRequest('{"status":400, "message":"' + e.message + '"}')
		}

	}
	
	@Get("/equipos/:idUsuario")
	def getEquipos() {

		try {
			var partidoParseado = this.parsearObjeto(restHost.getEquiposDelUsuario(idUsuario),
				ViewsEquipo.ListView)
			ok(partidoParseado)
		}
		catch (UserDoesntExist e) {
			notFound('{"status":404, "message":"' + e.message + '"}')
		}  
		catch (Exception e) {
			badRequest('{"status":400, "message":"' + e.message + '"}')
		}

	}
	
	@Post("/equipos")
	def postEquipos(@Body String body) {
		
		//Si lo entendes en menos de 5 segundos te regalo una galletita


		val jsonBody = new JSONObject(body)
		
		//Recibo esto integrantes :["U1", "U2"...] lo parseo a una lista de javaObjects con los datos del back
		val integrantesPosta = jsonBody.getJSONArray("integrantes").map[repoUsuario.searchById(it.toString)].toList
		
		//Esa lista de java objects la vuelvo a parsear a JSON y se la paso al body
		jsonBody.remove("integrantes")
		jsonBody.put("integrantes", new JSONArray(integrantesPosta.toJson))
		
		//Repito la operacion con el owner
		val ownerPosta = repoUsuario.searchById(jsonBody.get("owner").toString)
		
		jsonBody.remove("owner")
		jsonBody.put("owner", new JSONObject(ownerPosta.toJson))
		
		//Parseo ahora si el body		
		val equipo = new Gson().fromJson(jsonBody.toString, Equipo)

		//TODO: Hacer esto bien
		
		try {
			restHost.crearNuevoEquipo(equipo)
			ok('{"status":200, "message":"ok"}')
		}
		catch (ObjectAlreadyExists e) {
			println("Object")
			badRequest('{"status":404, "message":"' + e.message + '"}')
		}  
		catch (Exception e) {
			badRequest('{"status":400, "message":"' + e.message + '"}')
			throw e
		}

	}

	/* Cosas del "JsonIgnore Dinamico" */
	def <ViewGeneric> parsearObjeto(Object elementoAParsear, Class<ViewGeneric> customView) {

		var mapper = new ObjectMapper();
		mapper.disable(MapperFeature.DEFAULT_VIEW_INCLUSION);

		var result = mapper.writerWithView(customView).writeValueAsString(elementoAParsear);
		return result
	}

}
