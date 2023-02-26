class TodoItem {
  final String? id;
  final String? title;
  final String? notes;
  final bool? done;

  TodoItem({
    this.id,
    this.title,
    this.notes,
    this.done,
  });

  factory TodoItem.fromMap(Map map) {
    return TodoItem(
      id: map['id'],
      title: map['title'],
      notes: map['notes'],
      done: map['done'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'notes': notes,
      'done': (done ?? false) ? 1 : 0,
    };
  }
}
