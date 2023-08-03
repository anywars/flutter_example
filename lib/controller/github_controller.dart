import 'package:flutter_example/common/utils.dart';
import 'package:flutter_example/model/item.dart';
import 'package:flutter_example/model/query.dart';
import 'package:flutter_example/provider/github_provider.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class GithubController extends GetxController {
  late final _provider = Get.find<GithubProvider>();

  final _pc = PagingController<int, Item>(firstPageKey: 0);
  PagingController<int, Item> get pc => _pc;


  @override
  void onInit() {
    _pc.addPageRequestListener((pageKey) {
      _dataLoad(page: pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    _pc.dispose();
    super.onClose();
  }

  Future onRefresh() async {
    _pc.itemList?.clear();
    _pc.refresh();

    await _dataLoad(page: 0);
  }
  
  onLoad() async {
    Utils.modalessProgress();
    await _dataLoad(page: 0);
    Utils.dismissModalessProgress();
  }

  final _perPage = 20;
  Future _dataLoad({required int page}) async {
    final query = Query(q: 'test', page: '$page', perPage: '$_perPage');
    final response = await _provider.getRepositories(query);

    final items = response.body?.items;
    if (items != null) {
      // _items.addAll(items);
      if ((_pc.itemList?.length ?? 0) >= (response.body?.totalCount ?? 0)) {
        _pc.appendLastPage(items);
      }
      else {
        _pc.appendPage(items, page + 1);
      }
    }
    // _page++;
  }


}