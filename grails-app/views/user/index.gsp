<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>

    <body>
        <div class="nav" role="navigation">
            <ul>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>

        <div id="list-user" class="content scaffold-list" role="main">
            <h1>Tous les utilisateurs</h1>

            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            %{--<f:table collection="${userList}" />--}%
            <table class="table">
                <tr>
                    <th>Username</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Mail</th>
                    <th>Tel</th>
                    <th>Birth Date</th>
                    <th>Creation date</th>
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