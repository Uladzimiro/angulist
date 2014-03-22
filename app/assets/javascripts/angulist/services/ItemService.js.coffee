angular.module('angulist').factory 'Item', ['$resource', ($resource) ->
  class Item
    constructor: ->
      @service = $resource('/api/items')

    create: (attrs) ->
      item = new @service(attrs)
      item.$save()

    all: ->
      @service.query()
]
