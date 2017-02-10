# コントローラーを定義する。今はこのように記載すると覚えておけば良い。
sampleApp = angular.module('sampleApp')

sampleApp.controller "TodoListCtrl", ($scope, TodoList, Todo) ->

  # 初期データを用意するメソッド
  # $scope.list.name  としてアクセスできる
  # $scope.list.todos としてアクセスできる
  $scope.init = ->
                                    # $scope.list = {
                                    #   'name'  : 'Todoリスト1',
                                    #   'todos' : [
                                    #     { 'description' : 'todo description1', 'completed' : false},
                                    #     { 'description' : 'todo description2', 'completed' : false}
                                    #   ]
                                    # }
    # TodoListとTodoのサービスオブジェクトを作成
    # TODO todo_listのidを動的に取得する(次の連載記事で対処)
    @todoListService = new TodoList()
    @todoService     = new Todo(1)
    # データを取得する(GET /api/todo_lists/:id => Api::TodoLists#show)
    $scope.list = @todoListService.find(1)




# todoを追加する
  $scope.addTodo = (todoDescription) ->
                                    # todo = { 'description' : todoDescription, 'completed' : false }
                                    # $scope.list.todos.unshift(todo)
                                    # $scope.todoDescription = ""
    # todoを追加する(POST /api/todo_lists/:todo_lsit_id/todos => Api::Todo#destroy)
    todo = @todoService.create(description: todoDescription, completed: false)
    # initメソッドで用意したtodosの一番最初にtodoを追加する
    $scope.list.todos.unshift(todo)
    # todo入力テキストフィールドを空にする
    $scope.todoDescription = ""



# todoを削除する
  $scope.deleteTodo = (todo) ->
                                    # # indexOfメソッドでtodoのindexを探し、spliceメソッドで削除する
                                    # $scope.list.todos.splice($scope.list.todos.indexOf(todo), 1)
    # todoをサーバーから削除する(DELETE /api/todo_lists/todo_list_id/todos/:id => Api::Todo#destroy)
    @todoService.delete(todo)
    # todoをangularjsのlistデータから削除する(indexOfメソッドでtodoのindexを探し、spliceメソッドで削除する)
    $scope.list.todos.splice($scope.list.todos.indexOf(todo), 1)


# todoの完了カラムをON/OFFするメソッド
  $scope.toggleTodo = (todo) ->
    @todoService.update(todo, completed: todo.completed)



  serverErrorHandler = ->
    alert("サーバーでエラーが発生しました。画面を更新し、もう一度試してください。")
