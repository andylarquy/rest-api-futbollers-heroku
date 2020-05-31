package ar.edu.unsam.proyecto.domain

import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsEquipo
import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsPartido
import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsUsuario
import com.fasterxml.jackson.annotation.JsonView
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@Entity
class Usuario {

	@JsonView(ViewsUsuario.IdView, ViewsPartido.DefaultView, ViewsEquipo.ListView)
	@Id @GeneratedValue
	Long idUsario

	@JsonView(ViewsUsuario.DefaultView)
	@Column()
	String nombre = ""
	
	@Column()
	@JsonView(ViewsUsuario.CredencialesView)
	String password = ""

	@Column()
	@JsonView(ViewsUsuario.PerfilView)
	String foto

	@Column()
	@JsonView(ViewsUsuario.PerfilView)
	String sexo

	@Column()
	@JsonView(ViewsUsuario.PerfilView)
	String posicion

	@Column()
	@JsonView(ViewsUsuario.DefaultView)
	String email

	@JsonView(ViewsUsuario.UbicacionView)
	@Column()
	Double lat

	@JsonView(ViewsUsuario.UbicacionView)
	@Column()
	Double lon

	def validar() {
		if (idUsario === null){
			throw new Exception('El usuario debe tener un ID')
		}
		
		if (nombre === null){
			throw new Exception('El usuario debe tener un nombre')
		}
		
		if (idUsario === null){
			throw new Exception('El usuario debe tener un ID')
		}
		
		//TODO: Validar password no trivial
		if (password === null){
			throw new Exception('El usuario debe tener una contraseña')
		}
		
		if (foto === null){
			throw new Exception('El usuario debe tener una foto de perfil')
		}
		
		if (sexo === null){
			throw new Exception('El usuario debe indicar su sexo')
		}
		
		if (posicion === null){
			throw new Exception('El usuario debe indicar su posicion preferida')
		}
		
		if (email === null){
			throw new Exception('El usuario debe tener un email')
		}
		
	}

	def tieneCredenciales(String email_, String password_) {
		email.equals(email_) && password.equals(password_)
	}

	def tieneEsteMail(String email) {

		this.email.equals(email)

	}

}
