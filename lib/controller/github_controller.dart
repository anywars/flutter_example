import 'package:flutter_example/model/item.dart';
import 'package:flutter_example/model/query.dart';
import 'package:flutter_example/provider/github_provider.dart';
import 'package:get/get.dart';

class GithubController extends GetxController {
  late final _provider = Get.find<GithubProvider>();

  RxList<Item> _items = <Item>[].obs;
  List<Item> get items => _items;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  test() async {
    final query = Query(q: 'test');
    final response = await _provider.getRepositories(query);

    final items = response.body?.items;
    if (items != null) {
      _items.addAll(items);
    }
  }
}