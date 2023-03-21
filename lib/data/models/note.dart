class Note {
  int? id;
  final String title;
  final String content;
  final String datetime;
  int isImportant;
  int isTodo;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.datetime,
    this.isImportant = 0,
    this.isTodo = 0,
  });

  factory Note.fromMap(Map<String, Object?> map) {
    return Note(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      datetime: map['datetime'] as String,
      isImportant: map['isImportant'] as int,
      isTodo: map['isTodo'] as int,
    );
  }

  Map<String, Object> toMap() {
    return <String, Object>{
      'title': title,
      'content': content,
      'datetime': datetime,
      'isImportant': isImportant,
      'isTodo': isTodo,
    };
  }

  Note copyWith(
      {int? id,
      String? title,
      String? content,
      String? datetime,
      int? isImportant,
      int? isTodo}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      datetime: datetime ?? this.datetime,
      isImportant: isImportant ?? this.isImportant,
      isTodo: isTodo ?? this.isTodo,
    );
  }
}
