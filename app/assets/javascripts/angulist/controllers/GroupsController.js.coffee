angular.module('angulist').controller 'GroupsController', ['$scope', 'Group', 'Item', ($scope, Group, Item) ->
  $scope.newGroup = {}
  $scope.newItem = {}

  $scope.init = ->
    @groupService = new Group()
    @itemService = new Item()
    $scope.groups = @groupService.all()
    $scope.items = @itemService.all()

  $scope.createGroup = ->
    @groupService.create($scope.newGroup).then (group) ->
      $scope.groups.unshift(group)
      $scope.newGroup = {}

  $scope.createItem = ->
    console.log @itemService
    @itemService.create($scope.newItem).then (item) ->
      $scope.items.unshift(item)
      $scope.newItem = {}
]
