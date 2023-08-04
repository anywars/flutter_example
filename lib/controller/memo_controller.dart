import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_example/model/entity/memo.dart';
import 'package:flutter_example/service/example_service.dart';
import 'package:get/get.dart';

class MemoController extends GetxController {
  late final _service = Get.find<ExampleService>();

  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  GlobalKey<FormState> get keyForm => _keyForm;

  RxList<Memo> _memos = <Memo>[].obs;
  List<Memo> get memos => _memos;

  StreamSubscription? _streamSub;


  @override
  void onInit() {
    _streamSub = _service.memoDao.findAllAsStream().listen((event) {
      _memos.clear();
      _memos.addAll(event);
    });
    super.onInit();
  }

  @override
  void onClose() {
    _streamSub?.cancel();
    super.onClose();
  }


  String? onValidate(String? text) {
    if (text?.isEmpty == true) return 'Memo Empty...';
  }

  onSavedMemo(String? memo) async {
    await _service.memoDao.insertMemo(Memo(
      memo: memo,
      sort: await _service.memoDao.count(),
      createdDate: DateTime.now().millisecondsSinceEpoch,
    ));
    _keyForm.currentState?.reset();
    Get.focusScope?.unfocus();
  }

  onDeleteMemo(Memo memo) async =>
    await _service.memoDao.deleteMemo(memo);

  onUpdateSort(List<Memo> memos) {
    int sort = 0;
    memos.forEach((memo) {
      memo.sort = sort++;
    });
    _service.memoDao.updateMemos(memos);
  }

  onSaveMemo() async {
    if (_keyForm.currentState?.validate() == true) {
      _keyForm.currentState?.save();
    }
  }

}