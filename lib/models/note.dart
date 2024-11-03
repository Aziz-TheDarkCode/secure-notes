class Note {
  final int? id;
  final String title;
  final String content;
  final DateTime createTime;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.createTime,
  });
}
