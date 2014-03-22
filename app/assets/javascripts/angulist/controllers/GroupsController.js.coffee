angular.module('angulist').controller 'GroupsController', ['$scope', 'Group', ($scope, Group) ->
  $scope.newGroup = {}

  $scope.init = ->
    @groupService = new Group()
    $scope.groups = @groupService.all()

  $scope.createGroup = ->
    @groupService.create($scope.newGroup).then (group) ->
      $scope.groups.unshift(group)
      $scope.newGroup = {}
]
