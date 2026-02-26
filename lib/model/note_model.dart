class Note{
  int? id;
  String title;
  String content;

  // Named Parameterized constructor
  Note({this.id, required this.title, required this.content});

  // Dart to Database
  Map<String, dynamic>toMap(){
    return{
      'id':id,
      'title':title,
      'content':content
    };
  }

  // Database to Dart
  factory Note.fromMap(Map<String, dynamic>map){
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content']
    );
  }
}