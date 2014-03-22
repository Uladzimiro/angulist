angular.module('angulist').factory 'Group', ['$resource', ($resource) ->
  class Group
    constructor: ->
      @service = $resource('/api/groups')

    create: (attrs) ->
      group = new @service(attrs)
      group.$save()

    all: ->
      @service.query()
]
  
