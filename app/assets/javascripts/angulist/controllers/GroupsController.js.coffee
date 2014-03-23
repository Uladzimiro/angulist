angular.module('angulist').controller 'GroupsController', ['$scope', 'Group', 'Item', ($scope, Group, Item) ->
  $scope.newGroup = {}
  $scope.currentGroup = {}
  $scope.newItem = {}

  $scope.activeQuantity = ->
    if $scope.items.length
      $scope.items.map((item) -> if item.completed then 0 else 1).reduce (prev, curr) -> prev + curr
    else
      0

  $scope.completedQuantity = ->
    if $scope.items.length
      $scope.items.length - $scope.activeQuantity()
    else
      0

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

  $scope.updateGroup = (group) ->
    @groupService.update(group)

  $scope.updateItem = (item) ->
    @itemService.update(item)

  $scope.deleteItem = (item) ->
    @itemService.delete(item).then ->
      $scope.items.splice($scope.items.indexOf(item), 1)

  $scope.deleteGroup = (group) ->
    @groupService.delete(group).then ->
      $scope.groups.splice($scope.groups.indexOf(group), 1)
      deleted = $scope.items.filter (item) -> item.group_id == group.id
      deleted.forEach (item) -> $scope.items.splice($scope.items.indexOf(item), 1)
      if $scope.currentGroup is group
        $scope.currentGroup = $scope.groups[0]
]
