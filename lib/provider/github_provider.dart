import 'package:flutter_example/model/github_response.dart';
import 'package:flutter_example/model/query.dart';
import 'package:get/get.dart';

class GithubProvider extends GetConnect {
  final _baseUrl = 'https://api.github.com';

  Future<Response<GithubResponse>> getRepositories(Query query) =>
      get('/search/repositories', query: query.toJson(), decoder: (json) => GithubResponse.fromJson(json));

  @override
  void onInit() {
    httpClient.baseUrl = _baseUrl;
    super.onInit();
  }

}