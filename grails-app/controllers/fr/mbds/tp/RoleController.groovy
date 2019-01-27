package fr.mbds.tp

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class RoleController {

    RoleService roleService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond roleService.list(params), model:[roleCount: roleService.count()]
    }

    def show(Long id) {
        def roleInstance = Role.get(id)
        def userRoleList = UserRole.findAllByRole(roleInstance)
        def userList = userRoleList.collect{ it.user }
        respond roleInstance, model: [role: roleInstance, userList: userList]
    }

    def create() {
        def userList = User.findAll()
        respond new Role(params), model: [userList: userList]
    }

    def save(Role role) {
        if (role == null) {
            notFound()
            return
        }
        role.authority = params.authority
        role.save(flush: true)

        if (params.get("members")) {
            def userList = User.getAll(params.list("members"))
            userList.each {
                new UserRole(user: it, role: role).save(flush: true)
            }
        }

        request.withFormat {
            form multipartForm {
                flash.message = "Groupe créé"
                redirect role
            }
            '*' { respond role, [status: CREATED] }
        }
    }

    def edit(Long id) {
        def userList = User.findAll()
        respond roleService.get(id), model: [userList: userList]
    }

    def update(Role role) {
        if (role == null) {
            notFound()
            return
        }
        role.authority = params.authority
        role.save(flush: true)

        if (params.get("members")) {
            def userList = User.getAll(params.list("members"))
            userList.each {
                new UserRole(user: it, role: role).save(flush: true)
            }
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'role.label', default: 'Role'), role.id])
                redirect role
            }
            '*'{ respond role, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        def roleInstance = Role.get(id)
        if (roleInstance) {
            // On récupère la liste des UserRole qui référencent le role que nous souhaitons effacer
            def userRoles = UserRole.findAllByRole(roleInstance)
            // On itère sur la liste et supprime chaque userRole
            userRoles.each {
                UserRole userRole ->
                    userRole.delete(flush: true)
            }
            // On peut enfin effacer l'instance de Role
            roleInstance.delete(flush: true)
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'role.label', default: 'Role'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
