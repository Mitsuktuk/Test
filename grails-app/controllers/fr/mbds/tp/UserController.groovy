package fr.mbds.tp

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class UserController {

    UserService userService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond userService.list(params), model:[userCount: userService.count()]
    }

    def show(Long id) {
        respond userService.get(id)
    }

    def create() {
        respond new User(params)
    }

    def save(User user) {
        if (user == null) {
            notFound()
            return
        }

        try {
            userService.save(user)
        } catch (ValidationException e) {
            respond user.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*' { respond user, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond userService.get(id)
    }

    def update(User user) {
        if (user == null) {
            notFound()
            return
        }

        try {
            userService.save(user)
        } catch (ValidationException e) {
            respond user.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*'{ respond user, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        def userInstance = User.get(id)
        if (userInstance) {
            // On récupère la liste des Messages qui ont été émis par l'utilisateur que nous souhaitons effacer
            def Messages = Message.findAllByAuthor(userInstance)
            // On récupère le place holder pour les users supprimés
            def userDeleted = User.findByUsername("userDeleted")
            // On itère sur la liste et on remplace l'auteur par notre place holder
            Messages.each {
                Message message ->
                    message.author = userDeleted
                    message.save(flush: true)
            }
            // On récupère la liste des UserMessage qui référencent l'user que nous souhaitons effacer
            def userMessages = UserMessage.findAllByUser(userInstance)
            // On itère sur la liste et supprime chaque userMessage
            userMessages.each {
                UserMessage userMessage ->
                    userMessage.delete(flush: true)
            }

            // On récupère la liste des UserRole qui référencent l'user que nous souhaitons effacer
            def userRoles = UserRole.findAllByUser(userInstance)
            // On itère sur la liste et supprime chaque userRole
            userRoles.each {
                UserRole userRole ->
                    userRole.delete(flush: true)
            }

            // On peut enfin effacer l'instance de User
            userInstance.delete(flush: true)
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
