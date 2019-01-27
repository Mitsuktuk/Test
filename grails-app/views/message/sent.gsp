<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'message.label', default: 'Messages')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>

<div id="list-message" class="content scaffold-list" role="main">
    <h1>Messages envoyés</h1>

    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

%{--<f:table collection="${messageList}" />--}%
    <table class="table">
        <tr>
            <th>Contenu</th>
        </tr>
        <g:each in="${messageList.reverse()}" var="message">
            <tr>
                <td><g:link controller="message" action="show" id="${message.id}">${message.messageContent}</g:link></td>
            </tr>
        </g:each>
    </table>

</div>
</body>
</html>