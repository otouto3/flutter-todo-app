class Todo {
  int id;
  String title;
  String date;
  bool isDone;

  Todo({this.id, this.title, this.date, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }

  factory Todo.fromDatabaseJson(Map<String, dynamic> data) => Todo(
        id: data['id'],
        title: data['title'],
        date: data['date'],
        isDone: data['is_done'] == 1 ? true : false,
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "title": this.title,
        "date": this.date,
        "is_done": this.isDone ? 1 : 0,
      };
}
