<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <h1>Tous les groupes</h1>
        <g:if test="${flash.message}">
            <div class="well">${flash.message}</div>
        </g:if>

        <table class="table">
            <tr>
                <th>Intitulé</th>
            </tr>
            <g:each in="${roleList}" var="role">
                <tr>
                    <td><g:link controller="role" action="show" id="${role.id}">${role.authority}</g:link></td>
                </tr>
            </g:each>
        </table>

        <nav>
            <ul class="pagination">
                <g:paginate total="${roleCount ?: 0}" />
            </ul>
        </nav>
    </body>
</html>