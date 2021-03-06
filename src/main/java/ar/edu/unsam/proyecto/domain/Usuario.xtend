package ar.edu.unsam.proyecto.domain

import ar.edu.unsam.proyecto.repos.RepositorioUsuario
import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsEquipo
import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsPartido
import ar.edu.unsam.proyecto.webApi.jsonViews.ViewsUsuario
import com.fasterxml.jackson.annotation.JsonView
import java.util.HashSet
import java.util.List
import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.JoinTable
import javax.persistence.ManyToMany
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@Entity
class Usuario {

	@JsonView(ViewsUsuario.IdView, ViewsPartido.DefaultView, ViewsEquipo.ListView)
	@Id @GeneratedValue
	Long idUsuario

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
	
	@JsonView(ViewsPartido.ListView)
	@ManyToMany
	List<Partido> partidos
	
	@JoinTable(name="Amistades")
	@ManyToMany
	Set <Usuario> amigos = new HashSet
	
	@Transient
	transient RepositorioUsuario repoUsuario = RepositorioUsuario.instance
	
	def tieneCredenciales(String email_, String password_) {
		email.equals(email_) && password.equals(password_)
	}

	def tieneEsteMail(String email) {
		this.email.equals(email)
	}
	
	def agregarPartido(Partido partido) {
		partidos.add(partido)
		repoUsuario.update(this)
	}

	def validar() {
		if (idUsuario === null){
			throw new Exception('El usuario debe tener un ID')
		}
		
		if (nombre === null){
			throw new Exception('El usuario debe tener un nombre')
		}
		
		if (idUsuario === null){
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
	
	def agregarAmigo(Usuario usuario){		
			amigos.add(usuario)
	}
	
	def crearAmistad(Usuario usuario){
		usuario.agregarAmigo(this)
		this.agregarAmigo(usuario)
	}

}
