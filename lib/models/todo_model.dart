class Todo {
  String text;
  bool done;

  Todo({this.text, this.done});

  factory Todo.fromMap(Map<String, dynamic> map) =>
      Todo(text: map['text'], done: map['done']);

  Map<String, dynamic> toMap() => {'text': text, 'done': done};
}
