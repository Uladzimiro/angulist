angular.module('angulist').directive 'activegroup', ->
  (scope, element, c) ->
    element.bind 'click', (e) ->
      element.siblings().removeClass('active')
      element.addClass('active')
