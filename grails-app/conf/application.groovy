

// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'fr.mbds.tp.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'fr.mbds.tp.UserRole'
grails.plugin.springsecurity.authority.className = 'fr.mbds.tp.Role'
grails.plugin.springsecurity.requestMap.className = 'fr.mbds.tp.UserRole'
grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.successHandler.alwaysUseDefault = true
grails.plugin.springsecurity.successHandler.defaultTargetUrl = '/message/received'
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	[pattern: '/',                  access: ['permitAll']],
	[pattern: '/error',             access: ['permitAll']],
	[pattern: '/index',             access: ['permitAll']],
	[pattern: '/index.gsp',         access: ['permitAll']],
	[pattern: '/shutdown',          access: ['permitAll']],
	[pattern: '/assets/**',         access: ['permitAll']],
	[pattern: '/**/js/**',          access: ['permitAll']],
	[pattern: '/**/css/**',         access: ['permitAll']],
	[pattern: '/**/images/**',      access: ['permitAll']],
	[pattern: '/**/favicon.ico',    access: ['permitAll']],
	[pattern: '/dbconsole/**', 	    access: ['ROLE_ADMIN']],
    [pattern: '/message/received',  access: ['permitAll']],
	[pattern: '/message/sent',      access: ['permitAll']],
    [pattern: '/message/create',    access: ['permitAll']],
    [pattern: '/message/show/**',   access: ['permitAll']],
    [pattern: '/message/save',      access: ['permitAll']],
    [pattern: '/**',                access: ['ROLE_ADMIN']],
	[pattern: '/api/**',            access: ['permitAll']]
]

grails.plugin.springsecurity.filterChain.chainMap = [
	[pattern: '/assets/**',      filters: 'none'],
	[pattern: '/**/js/**',       filters: 'none'],
	[pattern: '/**/css/**',      filters: 'none'],
	[pattern: '/**/images/**',   filters: 'none'],
	[pattern: '/**/favicon.ico', filters: 'none'],
	[pattern: '/**',             filters: 'JOINED_FILTERS']
]

