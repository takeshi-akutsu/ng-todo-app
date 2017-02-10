# コントローラーを定義する。今はこのように記載すると覚えておけば良い。
sampleApp = angular.module('sampleApp')

sampleApp.controller "TodoListCtrl", ($scope) ->

  # 初期データを用意するメソッド
  # $scope.list.name  としてアクセスできる
  # $scope.list.todos としてアクセスできる
  $scope.init = ->
    $scope.list = {
      'name'  : 'Todoリスト1',
      'todos' : [
        { 'description' : 'todo description1'},
        { 'description' : 'todo description2'}
      ]
    }
