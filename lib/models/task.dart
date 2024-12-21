class Task {
  String id;
  String title;
  String description;
  String status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.status = 'To-Do',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
    };
  }
}