import 'package:flutter_example/model/item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_response.g.dart';


@JsonSerializable(fieldRename: FieldRename.snake)
class GithubResponse {
  GithubResponse({this.totalCount, this.incompleteResults, this.items});

  double? totalCount;
  bool? incompleteResults;
  List<Item>? items;

  factory GithubResponse.fromJson(Map<String, dynamic> json) =>
      _$GithubResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GithubResponseToJson(this);
}