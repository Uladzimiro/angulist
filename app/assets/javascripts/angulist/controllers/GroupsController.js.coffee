angular.module('angulist').controller 'GroupsController', ['$scope', 'Group', 'Item', ($scope, Group, Item) ->
  $scope.newGroup = {}
  $scope.currentGroup = {}
  $scope.newItem = {}

  $scope.init = ->
    @groupService = new Group()
    @itemService = new Item()
    $scope.groups = @groupService.all((groups) ->
      $scope.currentGroup = groups[0]
    )
    $scope.items = @itemService.all()

  $scope.changeCurrentGroup = (group) ->
    $scope.currentGroup = group

  $scope.createGroup = ->
    @groupService.create($scope.newGroup).then (group) ->
      $scope.groups.unshift(group)
      $scope.newGroup = {}

  $scope.createItem = ->
    $scope.newItem.group_id = $scope.currentGroup.id
    @itemService.create($scope.newItem).then (item) ->
      $scope.items.unshift(item)
      $scope.newItem = {}

  $scope.toggleItemCompletion = (item) ->
    @itemService.update(item)
]
