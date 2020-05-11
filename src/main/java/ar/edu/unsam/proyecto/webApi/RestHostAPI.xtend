package ar.edu.unsam.proyecto.webApi

import ar.edu.unsam.proyecto.domain.Equipo
import ar.edu.unsam.proyecto.domain.Partido
import ar.edu.unsam.proyecto.domain.Usuario
import ar.edu.unsam.proyecto.exceptions.IncorrectCredentials
import ar.edu.unsam.proyecto.exceptions.UserDoesntExist
import ar.edu.unsam.proyecto.repos.RepositorioCancha
import ar.edu.unsam.proyecto.repos.RepositorioEmpresa
import ar.edu.unsam.proyecto.repos.RepositorioEquipo
import ar.edu.unsam.proyecto.repos.RepositorioUsuario
import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsEquipo
import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsPartido
import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsUsuario

import com.fasterxml.jackson.databind.MapperFeature
import com.fasterxml.jackson.databind.ObjectMapper

import com.google.gson.Gson
import java.time.LocalDateTime
import org.json.JSONObject

import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.json.JSONUtils

@Controller
class RestHostAPI {
	extension JSONUtils = new JSONUtils
	RestHost restHost
	
	RepositorioUsuario repoUsuario = RepositorioUsuario.instance
	RepositorioEquipo repoEquipo = RepositorioEquipo.instance
	RepositorioEmpresa repoEmpresa = RepositorioEmpresa.instance
	RepositorioCancha repoCancha = RepositorioCancha.instance

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
		try {
			val usuarioParseado = this.parsearObjeto(restHost.loguearUsuario(usuario.email, usuario.password),
				ViewsUsuario.CredencialesView)

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
	
	//TODO: Terminar y testear
	@Post("/partidos")
	def postPartidos(@Body String body){
		try{
			
			val jsonBody = new JSONObject(body)
			
			//TODO: Delegar en un metodo abajo de todo bien escondido
			val LocalDateTime fechaDeReservaAsLocalDate = LocalDateTime.parse(jsonBody.get("fechaDeReserva").toString)
			jsonBody.remove("fechaDeReserva")
			
			val ownerPosta = repoUsuario.searchById(jsonBody.get("owner").toString)
			jsonBody.remove("owner")
			
			val equipo1Posta = repoEquipo.searchById(jsonBody.get("equipo1").toString)
			jsonBody.remove("equipo1")
			
			val equipo2Posta = repoEquipo.searchById(jsonBody.get("equipo2").toString)
			jsonBody.remove("equipo2")
			
			val empresaPosta = repoEmpresa.searchById(jsonBody.get("empresa").toString)
			jsonBody.remove("empresa")
			
			val canchaPosta = repoCancha.searchById(jsonBody.get("canchaReservada").toString)
			jsonBody.remove("canchaReservada")
			
			val partidoPosta = jsonBody.toString.fromJson(Partido)
			partidoPosta.fechaDeReserva = fechaDeReservaAsLocalDate
			partidoPosta.owner = ownerPosta
			partidoPosta.equipo1 = equipo1Posta
			partidoPosta.equipo2 = equipo2Posta
			partidoPosta.empresa = empresaPosta
			partidoPosta.canchaReservada = canchaPosta
			
			println("\n[DEBUG]: El partido "+partidoPosta+"\n[DEBUG]: Fue parseado con ID: "+partidoPosta.id+"\n[DEBUG]: Y con fecha de reserva: "+partidoPosta.fechaDeReserva+"\n")
			
			restHost.crearNuevoPartido(partidoPosta)
			
			ok('{"status":200, "message":"ok"}')
		}catch(Exception e){
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
		
		//Si lo entendes en menos de 15 segundos te regalo una galletita
		
		val jsonBody = new JSONObject(body)
		val idIntegrantes = jsonBody.getJSONArray("integrantes")
		
		// Con el ID de los integrantes voy al back y obtengo  una lista de objetos de java
		val integrantesPosta = idIntegrantes.map[repoUsuario.searchById(it.toString)].toList

		//Elimino la lista de integrantes. Despues de parsear el partido se la paso
		jsonBody.remove("integrantes")
		
		
		//Repito la operacion con el owner
		val ownerPosta = repoUsuario.searchById(jsonBody.get("owner").toString)
		jsonBody.remove("owner")
		
		//Parseo ahora si el body		
		val equipoPosta = new Gson().fromJson(jsonBody.toString, Equipo)
		
		equipoPosta.integrantes = integrantesPosta
		equipoPosta.owner = ownerPosta

		try {
			restHost.crearNuevoEquipo(equipoPosta)
			ok('{"status":200, "message":"ok"}')
		} catch (Exception e) {
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
