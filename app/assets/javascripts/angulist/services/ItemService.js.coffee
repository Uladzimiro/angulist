angular.module('angulist').factory 'Item', ['$resource', ($resource) ->
  class Item
    constructor: ->
      @service = $resource('/api/items/:id', null,
        update: {method: 'PATCH'}
      )

    create: (attrs) ->
      new @service(attrs).$save()

    update: (item) ->
      new @service(item).$update(id: item.id)

    all: ->
      @service.query()
]
