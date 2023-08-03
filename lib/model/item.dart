import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';


@JsonSerializable(fieldRename: FieldRename.snake)
class Item {
  Item({this.id, this.nodeId, this.name, this.fullName, this.private, this.url, this.description, this.htmlUrl});

  double? id;
  String? nodeId;
  String? name;
  String? fullName;
  bool? private;
  String? url;
  String? description;
  String? htmlUrl;

  factory Item.fromJson(Map<String, dynamic> json) =>
      _$ItemFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ItemToJson(this);
}