<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a class="btn btn-default" href="${g.createLink(controller: "user", action: "index")}" role="button">Retour aux utilisateurs</a>
        <div id="show-user" class="content scaffold-show" role="main">
            <h1>Détails de l'utilisateur</h1>

            <g:if test="${flash.message}">
                <div class="well">${flash.message}</div>
            </g:if>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Prénom</h3>
                </div>
                <div class="panel-body">
                    ${user.firstName}
                </div>
                <div class="panel-heading">
                    <h3 class="panel-title">Nom de famille</h3>
                </div>
                <div class="panel-body">
                    ${user.lastName}
                </div>
                <div class="panel-heading">
                    <h3 class="panel-title">Nom d'utilisateur</h3>
                </div>
                <div class="panel-body">
                    ${user.username}
                </div>
                <div class="panel-heading">
                    <h3 class="panel-title">Adresse mail</h3>
                </div>
                <div class="panel-body">
                    ${user.mail}
                </div>
                <div class="panel-heading">
                    <h3 class="panel-title">Anniversaire</h3>
                </div>
                <div class="panel-body">
                    ${user.dob}
                </div>
                <div class="panel-heading">
                    <h3 class="panel-title">Téléphone</h3>
                </div>
                <div class="panel-body">
                    ${user.tel}
                </div>


            </div>

            <g:form resource="${this.user}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="btn edit" action="edit" resource="${this.user}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="btn btn-danger delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
