class Task {
  final String name;
  final String date;
  bool isDone;

  Task({this.name, this.date = '', this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}
