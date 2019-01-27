<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a class="btn btn-default" href="${g.createLink(controller: "role", action: "index")}" role="button">Retour aux groupes</a>
        <div id="show-role" class="content scaffold-show" role="main">
            <h1>Détails du groupe</h1>

            <g:if test="${flash.message}">
                <div class="well">${flash.message}</div>
            </g:if>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Intitulé</h3>
                </div>
                <div class="panel-body">
                    ${role.authority}
                </div>

                <div class="panel-heading">
                    <h3 class="panel-title">Membres</h3>
                </div>
                <div class="panel-body">
                    <g:each in="${userList}" var="user">
                        <g:link controller="user" action="show" id="${user.id}">
                            ${user.firstName + " " + user.lastName},
                        </g:link>
                    </g:each>
                </div>
            </div>

            <g:form resource="${this.role}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit btn" action="edit" resource="${this.role}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="delete btn btn-danger" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
