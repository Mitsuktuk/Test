package fr.mbds.tp

import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class MessageController {

    MessageService messageService
    SpringSecurityService springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond messageService.list(params), model:[messageCount: messageService.count()]
    }

    def received() {
        def userMessageList = UserMessage.findAllByUser(springSecurityService.currentUser)
        def messageList = userMessageList.collect{ it.message }
        respond messageList, model: [messageList: messageList]
    }

    def sent() {
        def messageList = Message.findAllByAuthor(springSecurityService.currentUser)
        respond messageList, model: [messageList: messageList]
    }

    def show(Long id) {
        def messageInstance = Message.get(id)
        def userMessageList = UserMessage.findAllByMessage(messageInstance)
        def userList = userMessageList.collect{ it.user }
        respond messageInstance, model: [userList: userList, message: messageInstance]
    }

    def create() {
        def userList = User.findAll()
        def roleList = Role.findAll()
        respond new Message(params), model: [userList: userList, roleList: roleList]
    }

    def save(Message message) {
        if (message == null) {
            notFound()
            return
        }
        message.author = User.get(params.author)
        message.messageContent = params.messageContent
        message.save(flush: true)

        if (params.get("receiver")) {
            def receiverInstance = User.get(params.receiver)
            if (receiverInstance)
                new UserMessage(user: receiverInstance, message: message).save(flush: true)
        }

        request.withFormat {
            form multipartForm {
                flash.message = "Message envoyé"
                redirect message
            }
            '*' { respond message, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond messageService.get(id)
    }

    def update(Message message) {
        if (message == null) {
            notFound()
            return
        }

        // récuper l'id du destinataire
        // instancier ce dernier
        def destinataire = User.get(params.receiver)

        // créer une instance de UserMessage correspondant à l'envoi de ce message
        // persister l'instance UserMessage nouvellement créée
        UserMessage.create(destinataire, message, true)

        // Si groupe spécifié :
        // Récupérer l'instance de Role désigné
        // Créer un nouveau UserMessage pour tous les utilisateurs dudit Groupe

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'message.label', default: 'Message'), message.id])
                redirect message
            }
            '*'{ respond message, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }
        def messageInstance = Message.get(id)

        // On récupère la liste des UserMessage qui référencent le message que nous souhaitons effacer
        def userMessages = UserMessage.findAllByMessage(messageInstance)

        // On itère sur la liste et efface chaque référence
        userMessages.each {
            UserMessage userMessage ->
                userMessage.delete(flush: true)
        }

        // On peut enfin effacer l'instance de Message
        messageInstance.delete(flush: true)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'message.label', default: 'Message'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'message.label', default: 'Message'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
