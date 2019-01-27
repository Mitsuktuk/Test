<%@ page import="fr.mbds.tp.User" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'message.label', default: 'Message')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>

    <body>
        <div id="edit-message" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>

            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>

            <g:hasErrors bean="${this.message}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.message}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>

            <g:form resource="${this.message}" method="PUT">
                <g:hiddenField name="version" value="${this.message?.version}" />

                <fieldset class="form">
                    <f:all bean="message"/>
                    <label for="receiver">Receiver</label>
                    <g:select name="receiver" from="${fr.mbds.tp.User.list()}" optionValue="username" optionKey="id" id="receiver"/>
                    <label for="group">Group</label>
                    <g:select name="group" from="${fr.mbds.tp.Role.list()}" noSelection="${['null':'Pas de groupe']}" optionValue="authority" optionKey="id" id="group"/>
                </fieldset>

                <fieldset class="buttons">
                    <input class="btn btn-success save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
