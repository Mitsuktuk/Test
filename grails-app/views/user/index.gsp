<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>

    <body>
        <a class="btn btn-success" href="${g.createLink(controller: "user", action: "create")}" role="button">Ajouter un utilisateur</a>

        <div id="list-user" class="content scaffold-list" role="main">
            <h1>Tous les utilisateurs</h1>

            <g:if test="${flash.message}">
                <div class="well">${flash.message}</div>
            </g:if>

            %{--<f:table collection="${userList}" />--}%
            <table class="table">
                <tr>
                    <th>Nom d'utilisateur</th>
                    <th>Nom</th>
                    <th>Prénom</th>
                    <th>Mail</th>
                    <th>Tel</th>
                    <th>Anniversaire</th>
                    <th>Date de création</th>
                </tr>
                <g:each in="${userList}" var="user">
                    <tr>
                        <td><g:link controller="user" action="show" id="${user.id}">${user.username}</g:link></td>
                        <td>${user.firstName}</td>
                        <td>${user.lastName}</td>
                        <td>${user.mail}</td>
                        <td>${user.tel}</td>
                        <td>${user.dob}</td>
                        <td>${user.dateCreated}</td>
                    </tr>
                </g:each>
            </table>

            <nav>
                <ul class="pagination">
                    <li><g:paginate total="${userCount ?: 0}" /></li>
                </ul>
            </nav>

        </div>
    </body>
</html>