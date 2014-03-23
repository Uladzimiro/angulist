angular.module('angulist').directive 'taskcounters', ->
  restrict: 'E'
  template: '<span>{{activeQuantity()}} Active </span>|<span> {{completedQuantity()}} Completed'
