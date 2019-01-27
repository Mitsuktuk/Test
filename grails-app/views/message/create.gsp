<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'message.label', default: 'Message')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="create-message" class="content scaffold-create" role="main">
            <h1>Envoyer un message</h1>

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

            <g:form resource="${this.message}" method="POST">
                <fieldset class="form">
                    <div class='form-group fieldcontain required'>
                        <label for='messageContent'>Message Content
                            <span class='required-indicator'>*</span>
                        </label>
                        <textarea class="form-control" type="text" name="messageContent" value="" required="" id="messageContent"></textarea>
                    </div>

                    <div class='form-group fieldcontain required'>
                        <label for="receiver">
                            Destinataire
                            <span class='required-indicator'>*</span>
                        </label>
                        <select multiple class="form-control" name="receiver" id="receiver">
                            <option value="" selected="selected"></option>
                            <g:each in="${userList}" var="user">
                                <option value="${user.id}" >${user.firstName + " " + user.lastName}</option>
                            </g:each>
                        </select>
                    </div>

                    <div class='form-group fieldcontain'>
                        <label for="role">Group</label>
                        <select multiple class="form-control" name="role" id="role">
                            <option value="" selected="selected"></option>
                            <g:each in="${roleList}" var="role">
                                <option value="${role.id}" >${role.authority}</option>
                            </g:each>
                        </select>
                    </div>

                    <input type="hidden" id="author" name="author" value="${sec.loggedInUserInfo(field:'id')}">
                </fieldset>
                <g:submitButton name="create" class="save btn btn-success" value="${message(code: 'default.button.create.label', default: 'Create')}" />
            </g:form>
        </div>
    </body>
</html>
