<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'message.label', default: 'Message')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>

    <body>
        <h1>Détails du message</h1>

        <g:if test="${flash.message}">
            <div class="well">${flash.message}</div>
        </g:if>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Contenu du message</h3>
            </div>
            <div class="panel-body">
                ${message.messageContent}
            </div>
            <div class="panel-heading">
                <h3 class="panel-title">Auteur</h3>
            </div>
            <div class="panel-body">
                <g:link controller="user" action="show" id="${message.author.id}">
                    ${message.author.firstName + " " + message.author.lastName},
                </g:link>
            </div>
            <div class="panel-heading">
                <h3 class="panel-title">Destinataires</h3>
            </div>
            <div class="panel-body">
                <g:each in="${userList}" var="user">
                    <g:link controller="user" action="show" id="${user.id}">
                        ${user.firstName + " " + user.lastName},
                    </g:link>
                </g:each>
            </div>
        </div>
    </body>
</html>
