package ar.edu.unsam.proyecto.webApi

import ar.edu.unsam.proyecto.domain.Cancha
import ar.edu.unsam.proyecto.domain.Empresa
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

import com.google.gson.GsonBuilder
import com.google.gson.JsonDeserializationContext
import com.google.gson.JsonDeserializer
import com.google.gson.JsonElement

import java.lang.reflect.Type
import java.time.LocalDateTime
import java.util.List

import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post

import org.uqbar.xtrest.json.JSONUtils

@Controller
class RestHostAPI {
	extension JSONUtils = new JSONUtils
	RestHost restHost

	new(RestHost restHost) {
		this.restHost = restHost
	}

	@Get("/index")
	def getPeticionDePrueba() {

		try {
			ok(restHost.getPeticionDePrueba())
		} catch (Exception e) {
			badRequest('{"status":400, "message":"' + e.message + '"}')
		}
	}

	@Post("/login")
	def loguearUsuario(@Body String body) {

		val Usuario usuario = body.fromJson(Usuario)
		try {
			val usuarioParseado = this.parsearObjeto(restHost.loguearUsuario(usuario.email, usuario.password),
				ViewsUsuario.CredencialesView)

			ok(usuarioParseado)
		} catch (IncorrectCredentials e) {
			forbidden('{"status":401, "message":"' + e.message + '"}')
		} catch (Exception e) {
			badRequest('{"status":400, "message":"' + e.message + '"}')
		}
	}

	@Post("/usuario")
	def signUpUsuario(@Body String body) {

		val Usuario usuario = body.fromJson(Usuario)

		try {
			restHost.signUpUsuario(usuario)
			ok('{"status": 200}')
		} catch (IncorrectCredentials e) {
			badRequest('{"status":400, "message":"' + e.message + '"}')
		} catch (Exception e) {
			badRequest('{"status":400, "message":"' + e.message + '"}')
		}
	}

	@Get("/partidos/:idUsuario")
	def getPartidos() {

		try {
			var partidoParseado = this.parsearObjeto(restHost.getPartidosDelUsuario(idUsuario), ViewsPartido.ListView)
			ok(partidoParseado)
		} catch (UserDoesntExist e) {
			notFound('{"status":404, "message":"' + e.message + '"}')
		} catch (Exception e) {
			badRequest('{"status":400, "message":"' + e.message + '"}')
		}
	}

	@Post("/partidos")
	def postPartidos(@Body String body) {
		try {
			// Seteo los adapter de ID a javaObject
			val gson = new GsonBuilder()
			.registerTypeAdapter(LocalDateTime, new LocalDateAdapter())
			.registerTypeAdapter(Usuario, new UsuarioAdapter())
			.registerTypeAdapter(Equipo, new EquiposAdapter())
			.registerTypeAdapter(Empresa, new EmpresaAdapter())
			.registerTypeAdapter(Cancha, new CanchaAdapter())
			.create()

			val partido = gson.fromJson(body.toString, Partido)

			println("\n[DEBUG]: El partido " + partido)
			println("[DEBUG]: Fue parseado con ID: " + partido.id)
			println("[DEBUG]: Y con fecha de reserva: " + partido.fechaDeReserva)

			restHost.crearNuevoPartido(partido)

			ok('{"status":200, "message":"ok"}')
		} catch (Exception e) {
			badRequest('{"status":400, "message":"' + e.message + '"}')
		}
	}

	@Get("/equipos/:idUsuario")
	def getEquipos() {

		try {
			var partidoParseado = this.parsearObjeto(restHost.getEquiposDelUsuario(idUsuario), ViewsEquipo.ListView)
			ok(partidoParseado)
		} catch (UserDoesntExist e) {
			notFound('{"status":404, "message":"' + e.message + '"}')
		} catch (Exception e) {
			badRequest('{"status":400, "message":"' + e.message + '"}')
		}

	}

	@Post("/equipos")
	def postEquipos(@Body String body) {

		try {
			val gson = new GsonBuilder().registerTypeAdapter(Usuario, new UsuarioAdapter).registerTypeAdapter(List,
				new UsuarioListAdapter()).create()

			val equipo = gson.fromJson(body, Equipo)

			restHost.crearNuevoEquipo(equipo)
			ok('{"status":200, "message":"ok"}')
		} catch (Exception e) {
			badRequest('{"status":400, "message":"' + e.message + '"}')
		}

	}

	//TODO: Testear GET /canchas
	@Get("/canchas")
	def getCanchas() {
		try {
			var canchasParseadas = restHost.getCanchas().toJson
			ok(canchasParseadas)
		} catch (Exception e) {
			badRequest('{"status":400, "message":"' + e.message + '"}')
		}
	}
	
	//TODO: Testear GET /empresas
	@Get("/empresas")
	def getEmpresas() {
		try {
			var empresaParseada = this.parsearObjeto(restHost.getEmpresas(), ViewsEquipo.ListView)
			ok(empresaParseada)
		} catch (Exception e) {
			badRequest('{"status":400, "message":"' + e.message + '"}')
		}
	}

	/* Auxiliares para pareo de JSONS (<3 Gracias Java, sos una verga) */
	/* TODO: Capaz podes mandar todo a un archivo auxiliar y separar esta logica de mierda */
	/* Cosas del "JsonIgnore Dinamico" con Jackson*/
	def <ViewGeneric> parsearObjeto(Object elementoAParsear, Class<ViewGeneric> customView) {

		var mapper = new ObjectMapper();
		mapper.disable(MapperFeature.DEFAULT_VIEW_INCLUSION);

		var result = mapper.writerWithView(customView).writeValueAsString(elementoAParsear);
		return result
	}

// GSON ADAPTERS SARASA
	static class LocalDateAdapter implements JsonDeserializer<LocalDateTime> {
		override deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) {
			println(json)
			LocalDateTime.parse(json.getAsJsonPrimitive().getAsString())
		}
	}

	static class UsuarioAdapter implements JsonDeserializer<Usuario> {
		val repoUsuario = RepositorioUsuario.instance

		override deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) {
			val idUsuario = json.getAsJsonPrimitive().getAsString()
			repoUsuario.searchById(idUsuario)
		}
	}

	static class UsuarioListAdapter implements JsonDeserializer<List<Usuario>> {
		val repoUsuario = RepositorioUsuario.instance

		override deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) {
			val idUsuarios = json.getAsJsonArray()
			val idUsuariosSinQuotes = idUsuarios.map[it.getAsJsonPrimitive().getAsString()]
			idUsuariosSinQuotes.map[repoUsuario.searchById(it)].toList
		}
	}

	static class EquiposAdapter implements JsonDeserializer<Equipo> {
		val repoEquipo = RepositorioEquipo.instance

		override deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) {
			val idEquipo = json.getAsJsonPrimitive().getAsString()
			return repoEquipo.searchById(idEquipo)
		}
	}

	static class EmpresaAdapter implements JsonDeserializer<Empresa> {
		val repoEmpresa = RepositorioEmpresa.instance

		override deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) {
			val idEmpresa = json.getAsJsonPrimitive().getAsString()
			return repoEmpresa.searchById(idEmpresa)
		}
	}

	static class CanchaAdapter implements JsonDeserializer<Cancha> {
		val repoCancha = RepositorioCancha.instance

		override deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) {
			val idCancha = json.getAsJsonPrimitive().getAsString()
			return repoCancha.searchById(idCancha)
		}
	}

}
