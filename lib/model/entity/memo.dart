import 'package:floor/floor.dart';


@Entity(tableName: 'memo')
class Memo {
  Memo({this.id, this.memo, this.sort = 0, this.createdDate});

  @PrimaryKey(autoGenerate: true)
  int? id;
  String? memo;
  int? sort;
  int? createdDate;
}