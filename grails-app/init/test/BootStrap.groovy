package test

import fr.mbds.tp.Message
import fr.mbds.tp.Role
import fr.mbds.tp.User
import fr.mbds.tp.UserMessage
import fr.mbds.tp.UserRole

class BootStrap {

    def init = { servletContext ->
        def userAdmin = new User(username: "admin", password: "secret", firstName: "admin", lastName: "admin", mail: "admin@mail").save(flush: true, failOnError: true)
        def roleAdmin = new Role(authority: "ROLE_ADMIN").save(flush: true, failOnError: true)
        UserRole.create(userAdmin, roleAdmin, true)

        def userDeleted = new User(username: "userDeleted", password: "secretDeleted", firstName: "userDeleted", lastName:"userDeleted", mail:"user@deleted").save(flush:true, failOnError: true)

        def groupAll = new Role(authority: "groupe_all").save(flush: true, failOnError: true)

        (1..50).each {
            def userInstance = new User(username: "username-$it", password: "password", firstName: "first-$it", lastName: "last-$it", mail: "mail-$it").save(flush: true, failOnError:true)
            new Message(messageContent: "lala", author: userInstance).save(flush: true, failOnError: true)
            UserRole.create(userInstance, groupAll, true)
        }

        Message.list().each {
            Message messageInstance ->
                User.list().each {
                    User userInstance ->
                        UserMessage.create(userInstance, messageInstance, true)
                }
        }

    }
    def destroy = {
    }
}
