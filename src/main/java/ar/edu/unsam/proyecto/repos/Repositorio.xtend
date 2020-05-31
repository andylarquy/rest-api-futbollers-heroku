package ar.edu.unsam.proyecto.repos

import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.PersistenceException
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Repositorio<T> {

	static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Futbollers")

	def getEntityManager() {
		entityManagerFactory.createEntityManager
	}

	def coleccion() {

		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			val result = entityManager.createQuery(query).resultList
			result
		} finally {
			entityManager?.close
		}
	}

	def Class<T> entityType()

	def create(T t) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				// ahora soy transient
				persist(t)
				transaction.commit
			// ahora persistent
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager.close
		// ahora soy detached
		}
	}

	def update(T t) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				merge(t)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager?.close
		}
	}

}
