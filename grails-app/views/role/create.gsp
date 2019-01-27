<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="create-role" class="content scaffold-create" role="main">
            <h1>Créer un groupe</h1>

            <g:if test="${flash.message}">
                <div class="well">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.role}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${this.role}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form resource="${this.role}" method="POST">
                <fieldset class="form">
                    <div class='form-group fieldcontain required'>
                        <label for='authority'>Intitulé
                            <span class='required-indicator'>*</span>
                        </label>
                        <input class="form-control" type="text" name="authority" value="" required="" id="authority" />
                    </div>

                    <div class='form-group fieldcontain required'>
                        <label for='members'>Membres
                            <span class='required-indicator'>*</span>
                        </label>
                        <select multiple class="form-control" name="members" id="members">
                            <g:each in="${userList}" var="user">
                                <option value="${user.id}" >${user.firstName + " " + user.lastName}</option>
                            </g:each>
                        </select>
                    </div>
                </fieldset>

                <fieldset class="buttons">
                    <g:submitButton name="create" class="save btn btn-success" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
