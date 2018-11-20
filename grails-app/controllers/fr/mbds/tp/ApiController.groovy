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
                        response.status = 404
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
                def authorInstance = params.author.id ? User.get(params.author.id) : null
                def messageInstance
                if (authorInstance) {
                    // Créer le message
                    messageInstance = new Message(author: authorInstance, messageContent: params.messageContent)
                    if (messageInstance.save(flush: true)) {
//                        // Ajouter destinataire
//                        if (params.receiver.id)
//                        {
//                            def receiverInstance = User.get(params.receiver.id)
//                            if (receiverInstance)
//                                new UserMessage(user: receiverInstance, message: messageInstance).save(flush: true)
//                        }

                        render(status: 201)
                    }
                }

                if (response.status != 201)
                    response.status = 400

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