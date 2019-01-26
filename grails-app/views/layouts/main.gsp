<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />

    <asset:stylesheet src="application.css"/>

    <g:layoutHead/>
</head>

<body>
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>

                <sec:ifLoggedIn>
                    <a class="navbar-brand" href="${g.createLink(controller: "message", action: "received")}">
                </sec:ifLoggedIn>
                <sec:ifNotLoggedIn>
                    <a class="navbar-brand" href="${g.createLink(controller: "message", action: "received")}">
                </sec:ifNotLoggedIn>
                    <asset:image src="logo.png" alt="Messagerie Logo"/>
                </a>
            </div>

            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <sec:ifNotLoggedIn>
                        <li><a href="${g.createLink(controller: "login", action: "auth")}">Connexion</a></li>
                    </sec:ifNotLoggedIn>
                    <sec:ifLoggedIn>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Messages <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="${g.createLink(controller: "message", action: "received")}">Reçus</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="${g.createLink(controller: "message", action: "create")}">Nouveau</a></li>
                            </ul>
                        </li>
                        <sec:ifAllGranted roles="ROLE_ADMIN">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Administration <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="${g.createLink(controller: "message")}">Messages</a></li>
                                    <li><a href="${g.createLink(controller: "user")}">Users</a></li>
                                    <li><a href="${g.createLink(controller: "role")}">Groups</a></li>
                                </ul>
                            </li>
                        </sec:ifAllGranted>
                        <li><a href="${g.createLink(controller: "logout")}">Déconnexion</a></li>
                    </sec:ifLoggedIn>

                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <g:layoutBody/>
    </div>

    <div class="footer" role="contentinfo"></div>

    <div id="spinner" class="spinner" style="display:none;">
        <g:message code="spinner.alt" default="Loading&hellip;"/>
    </div>

    <asset:javascript src="application.js"/>
</body>
</html>
