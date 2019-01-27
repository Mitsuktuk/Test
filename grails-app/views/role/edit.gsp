<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="edit-role" class="content scaffold-edit" role="main">
            <h1>Editer le groupe ${this.role.authority}</h1>

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

            <g:form resource="${this.role}" method="PUT">
                <g:hiddenField name="version" value="${this.role?.version}" />
                <fieldset class="form">
                    <div class='form-group fieldcontain required'>
                        <label for='authority'>Intitulé
                            <span class='required-indicator'>*</span>
                        </label>
                        <input class="form-control" type="text" name="authority" value="${this.role.authority}" required="" id="authority" />
                    </div>

                    <div class='form-group fieldcontain required'>
                        <label for='members'>Ajouter des membres
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
                    <input class="save btn btn-success" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
