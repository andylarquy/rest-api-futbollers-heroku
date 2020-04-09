package ar.edu.unsam.proyecto.webApi

import ar.edu.unsam.proyecto.domain.Usuario
import com.fasterxml.jackson.databind.MapperFeature
import com.fasterxml.jackson.databind.ObjectMapper
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Put
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

		return ok(restHost.getPeticionDePrueba())
	}
}
