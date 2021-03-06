package fr.mbds.tp

import grails.converters.JSON
import grails.converters.XML

import javax.servlet.http.HttpServletRequest

class ApiController {

    def index() { render "ok" }

    def message() {
        switch (request.getMethod()) {
            case "GET":
                if (params.id) { // on doit retourner une instance de message
                    def messageInstance = Message.get(params.id)
                    if (messageInstance)
                        reponseFormat(messageInstance, request)
                    else
                        render(status: 404, text: "Le message avec l'id ${params.id} est introuvable")
                } else // on doit retourner la liste de tous les messages
                    forward action: "messages"
                break
            case "POST":
                forward action: "messages"
                break
            case "PUT":
                def messageInstance = params.id ? Message.get(params.id) : null
                if (messageInstance) {
                    if (params.get("author.id")) {
                        def authorInstance = User.get(params.get("author.id"))
                        if (authorInstance)
                            messageInstance.author = authorInstance
                    }

                    if(params.messageContent)
                        messageInstance.messageContent = params.messageContent

                    if(messageInstance.save(flush: true))
                        render(text: "Mise à jour effectuée pour le message ${messageInstance.id}")
                    else
                        render(status: 400, text: "Echec de la mise à jour du message ${messageInstance.id}")
                } else {
                    render(status: 404, text: "Le message désigné est introuvable")
                }
                break
            case "DELETE":
                def messageInstance = params.id ? Message.get(params.id) : null
                if (messageInstance) {
                    // On récupère la liste des UserMessage qui référencent le message que nous souhaitons effacer
                    def userMessages = UserMessage.findAllByMessage(messageInstance)
                    // On itère sur la liste et efface chaque référence
                    userMessages.each {
                        UserMessage userMessage ->
                            userMessage.delete(flush: true)
                    }
                    // On peut enfin effacer l'instance de Message
                    messageInstance.delete(flush: true)
                    render(status: 200, text: "message effacé")
                } else
                    render(status: 404, text: "message introuvable")
                break
            default:
                response.status = 405
                break
        }
    }

    def messages() {
        switch (request.getMethod()) {
            case "GET":
                reponseFormatList(Message.list(), request)
                break
            case "POST":
                // Vérifier auteur
                def authorInstance = params.get("author.id") ? User.get(params.get("author.id")) : null
                def messageInstance
                if (authorInstance) {
                    // Créer le message
                    messageInstance = new Message(author: authorInstance, messageContent: params.messageContent)
                    if (messageInstance.save(flush: true)) {
                        // Ajouter destinataire
                        if (params.get("receiver.id"))
                        {
                            def receiverInstance = User.get(params.receiver.id)
                            if (receiverInstance)
                                new UserMessage(user: receiverInstance, message: messageInstance).save(flush: true)
                        }

                        render(status: 201, text: "Message créé")
                    }
                }

                if (response.status != 201)
                    render(status: 400, text: "Message non créé")

                break
        }
    }

    def user() {
        switch (request.getMethod()) {
            case "GET":
                if (params.id) { // on doit retourner une instance de user
                    def userInstance = User.get(params.id)
                    if (userInstance)
                        reponseFormat(userInstance, request)
                    else
                        render(status: 404, text: "L'utilisateur avec l'id ${params.id} est introuvable")
                } else // on doit retourner la liste de tous les messages
                    forward action: "users"
                break
            case "POST":
                forward action: "users"
                break
            case "PUT":
                def userInstance = params.id ? User.get(params.id) : null
                if (userInstance) {
                    if (params.username)
                        userInstance.username = params.username

                    if (params.password)
                        userInstance.password = params.password

                    if (params.firstName)
                        userInstance.firstName = params.firstName

                    if (params.lastName)
                        userInstance.lastName = params.lastName

                    if (params.mail)
                        userInstance.mail = params.mail

                    if(userInstance.save(flush: true))
                        render(text: "Mise à jour effectuée pour le user ${userInstance.id}")
                    else
                        render(status: 400, text: "Echec de la mise à jour du user ${userInstance.id}")
                } else {
                    render(status: 404, text: "Le user désigné est introuvable")
                }
                break
            case "DELETE":
                def userInstance = params.id ? User.get(params.id) : null
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
                    render(status: 200, text: "user effacé")
                } else
                    render(status: 404, text: "user introuvable")
                break
            default:
                response.status = 405
                break
        }
    }

    def users() {
        switch (request.getMethod()) {
            case "GET":
                reponseFormatList(User.list(), request)
                break
            case "POST":
                def userInstance
                // Créer le user
                userInstance = new User(username: params.username, password: params.password, firstName: params.firstName, lastName: params.lastName, mail: params.mail)
                if (userInstance.save(flush: true))
                    render(status: 201, text: "user créé")
                if (response.status != 201)
                    render(status: 400, text: "user non créé")
                break
            default:
                response.status = 405
                break
        }
    }

    def messageToUser() {
        switch (request.getMethod()) {
            case "POST":
                if (params.get("user.id")) {
                    def userInstance = User.get(params.get("user.id"))
                    if (userInstance) {
                        def messageInstance;
                        if (params.get("message.id")) {
                            messageInstance = Message.get(params.get("message.id"))
                        } else {
                            def authorInstance = params.get("author.id") ? User.get(params.get("author.id")) : null
                            if (authorInstance)
                                messageInstance = new Message(author: authorInstance, messageContent: params.messageContent).save(flush: true)
                        }
                        if(messageInstance) {
                            def userMessageInstance =  new UserMessage(message: messageInstance, user: userInstance)
                            if(userMessageInstance.save(flush: true))
                                render(status: 201, text: "Attribution du message ${messageInstance.id} à l'user ${userInstance.id} réussie.")
                        } else {
                            render(status: 400, text: "Message non récupéré - ")
                        }
                    } else {
                        render(status: 404, text: "user introuvable - ")
                    }
                }

                if (response.status != 201)
                    render(status: 400, text: "Message non attribué")

            default:
                response.status = 405
                break
        }
    }

    def messageToGroup() {
        switch (request.getMethod()) {
            case "POST":
                if (params.get("group.id")) {
                    def roleInstance = Role.get(params.get("group.id"))
                    def userRoleList = UserRole.findAllByRole(roleInstance)
                    def userList = userRoleList.collect{ it.user }
                    if (roleInstance) {
                        def messageInstance;
                        if (params.get("message.id")) {
                            messageInstance = Message.get(params.get("message.id"))
                        } else {
                            def authorInstance = params.get("author.id") ? User.get(params.get("author.id")) : null
                            if (authorInstance)
                                messageInstance = new Message(author: authorInstance, messageContent: params.messageContent).save(flush: true)
                        }
                        if(messageInstance) {
                            for (user in userList) {
                                def userMessageInstance =  new UserMessage(message: messageInstance, user: user)
                                if(userMessageInstance.save(flush: true))
                                    render(status: 201, text: "Attribution du message ${messageInstance.id} à l'user ${user.id} réussie. ")
                            }
                        } else {
                            render(status: 400, text: "Message non récupéré - ")
                        }
                    } else {
                        render(status: 404, text: "Groupe introuvable - ")
                    }
                }

                if (response.status != 201)
                    render(status: 400, text: "Message non attribué")

            default:
                response.status = 405
                break
        }
    }

    def reponseFormat(Object instance, HttpServletRequest request) {
        switch (request.getHeader("Accept")) {
            case "text/xml":
                render instance as XML
                break
            case "text/json":
                render instance as JSON
                break
            default:
                response.status = 415
                break
        }
    }

    def reponseFormatList(List list, HttpServletRequest request) {
        switch (request.getHeader("Accept")) {
            case "text/xml":
                render list as XML
                break
            case "text/json":
                render list as JSON
                break
            default:
                response.status = 415
                break
        }
    }
}
