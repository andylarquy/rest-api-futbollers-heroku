package ar.edu.unsam.proyecto.webApi

import ar.edu.unsam.proyecto.runnable.Bootstrap
import org.uqbar.xtrest.api.XTRest

class WebApp {

	def static void main(String[] args) {

		// CHEATSHEET
		// Para no usar helper method delego en una nueva clase
		// las instanciacion y uso los objetos acá
		// val Bootstrap bootstrap = Bootstrap.getInstance()	
		// bootstrap.runBootstrap()
		val restHost = new RestHost => [
			/*repoIndividuo = instancias.repoSuperInd
			 * repoEquipo = instancias.repoEquipo
			 * repoAmenaza = instancias.repoAmenaza
			 repoItem = instancias.repoItem*/
			// parametros y cosas locas
		]

		XTRest.startInstance(9001, new RestHostAPI(restHost))
	}

}
