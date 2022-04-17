import 'package:objectbox/objectbox.dart';

@Entity()
class Note {
  int? id;

  String? text;

  @Property(type: PropertyType.date) // Store as int in milliseconds
  DateTime date;

  @Transient() // Make this field ignored, not stored in the database.
  int? notPersisted;

  Note({this.text, DateTime? date}) : date = date ?? DateTime.now();

  @override
  String toString() => 'Note{id: $id, text: $text}';
}