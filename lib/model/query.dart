import 'package:json_annotation/json_annotation.dart';

part 'query.g.dart';


@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class Query {
  Query({required this.q, this.page, this.perPage, this.sort = 'stars'});

  String? q;
  String? page;
  String? perPage;
  String sort = 'stars';

  factory Query.fromJson(Map<String, dynamic> json) =>
      _$QueryFromJson(json);

  Map<String, dynamic> toJson() =>
      _$QueryToJson(this);
}