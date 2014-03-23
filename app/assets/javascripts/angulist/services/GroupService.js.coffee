angular.module('angulist').factory 'Group', ['$resource', ($resource) ->
  class Group
    constructor: ->
      @service = $resource('/api/groups/:id', null,
        update: {method: 'PATCH'}
      )

    create: (attrs) ->
      new @service(attrs).$save()

    update: (group) ->
      new @service(group).$update(id: group.id)

    delete: (group) ->
      new @service(group).$delete(id: group.id)

    all: (callback)->
      @service.query(callback)
]
  
