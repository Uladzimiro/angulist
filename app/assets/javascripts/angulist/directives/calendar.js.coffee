angular.module('angulist').directive 'calendar', ->
  restrict: 'E'
  template: '<div class="datepicker-button button small">Date</div>'
  scope: 
    model: '='
    onChange: '&'

  link: (scope, element, attrs) ->
    input = angular.element('<input class="hidden-input" type="text">')
    element.append(input)
    input.datepicker(dateFormat: 'yy-mm-dd')
    input.datepicker('setDate', scope.model)

    element.bind 'click', ->
      input.datepicker('show')

    input.bind 'change', ->
      scope.model = input.val()
      scope.$apply()
      scope.onChange()
      scope.$apply()
