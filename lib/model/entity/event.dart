import 'package:floor/floor.dart';


@Entity(tableName: 'event')
class Event {
  Event({this.id, this.memo, this.date});

  @PrimaryKey(autoGenerate: true)
  int? id;
  String? memo;
  int? date;
}