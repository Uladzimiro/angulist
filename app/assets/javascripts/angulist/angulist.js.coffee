angulist = angular.module('angulist', ['ngResource', 'ngRoute', 'mk.editablespan'])

angulist.config ['$httpProvider', ($httpProvider) ->
  authToken = $('meta[name="csrf-token"]').attr('content')
  $httpProvider.defaults.headers.common['X-CSRF-TOKEN'] = authToken
]

# angulist.config ['$routeProvider', ($routeProvider) ->
#   $routeProvider.
