<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'message.label', default: 'Messages')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>

    <body>
        <div class="nav" role="navigation">
            <ul>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-message" class="content scaffold-list" role="main">
            <h1>Tous les messages</h1>

            <g:if test="${flash.message}">
                <div class="well">${flash.message}</div>
            </g:if>

            %{--<f:table collection="${messageList}" />--}%
            <table class="table">
                <tr>
                    <th>Contenu</th>
                    <th>Auteur</th>
                </tr>
                <g:each in="${messageList}" var="message">
                    <tr>
                        <td><g:link controller="message" action="show" id="${message.id}">${message.messageContent}</g:link></td>
                        <td>${message.author.username}</td>
                    </tr>
                </g:each>
            </table>

            <nav>
                <ul class="pagination">
                    <li><g:paginate total="${messageCount ?: 0}" /></li>
                </ul>
            </nav>

        </div>
    </body>
</html>