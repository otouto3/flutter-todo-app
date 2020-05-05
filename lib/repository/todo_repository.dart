import '../models/todo.dart';
import '../dao/todo_dao.dart';

class TodoRepository {
  final todoDao = TodoDao();

  Future getAllTodos() => todoDao.getAll();

  Future insertTodo(Todo todo) => todoDao.create(todo);

  Future updateTodo(Todo todo) => todoDao.update(todo);

  Future deleteTodoById(int id) => todoDao.delete(id);

  //not use this sample
  Future deleteAllTodos() => todoDao.deleteAll();
}
