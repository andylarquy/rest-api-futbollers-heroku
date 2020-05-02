package ar.edu.unsam.proyecto.webApi

import ar.edu.unsam.proyecto.runnable.Bootstrap
import org.uqbar.xtrest.api.XTRest

class WebApp {

	def static void main(String[] args) {
		var int port 
		try {
			port = Integer.parseInt(System.getenv("PORT"))
		} catch (NumberFormatException e) {
			println("Probablemente te olvidaste de cambiar el PORT")
			println("GIF Explicativo: https://i.imgur.com/5m4o9xg.gif")
			throw e
		}
		
		// CHEATSHEET
		// Para no usar helper method delego en una nueva clase
		// las instanciacion y uso los objetos acá
		val Bootstrap bootstrap = Bootstrap.getInstance()
		bootstrap.runBootstrap()
		val restHost = new RestHost => [
			/*repoIndividuo = instancias.repoSuperInd
			 * repoEquipo = instancias.repoEquipo
			 * repoAmenaza = instancias.repoAmenaza
			 repoItem = instancias.repoItem*/
			// parametros y cosas locas
		]

		XTRest.startInstance(port, new RestHostAPI(restHost))
	}

}
