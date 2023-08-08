import 'package:flutter/cupertino.dart';
import 'package:flutter_example/common/date_time.dart';
import 'package:flutter_example/model/entity/event.dart';
import 'package:flutter_example/model/entity/event_add.dart';
import 'package:flutter_example/service/example_service.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  final _keyForm = GlobalKey<FormState>();
  GlobalKey<FormState> get keyForm => _keyForm;

  final _service = Get.find<ExampleService>();
  final _start = 0.obs;
  final _end = 0.obs;

  final _now = DateTime.now();
  final _focusedDay = DateTime.now().obs;
  final _currentDay = DateTime.now().obs;
  DateTime get focusedDay => _focusedDay.value;
  DateTime get currentDay => _currentDay.value;
  DateTime get firstDay => DateTime(2000, 1, 1);
  DateTime get lastDay =>
      _now.add(Duration(days: DateTime.daysPerWeek - _now.weekday));

  final _events = <Event>[].obs;
  List<Event> get events => _events;
  List<Event> get todayEvents =>
      onCurrentEvent(_currentDay.value);


  @override
  void onInit() {
    onPageChanged(_now);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String? validator(String? text) {
    if (text?.isEmpty == true) return 'Empty';
    return null;
  }

  void onSaved(String? memo) async {
    Get.focusScope?.unfocus();
    final id = await _service.eventDao.insertEvent(Event(memo: memo, date: _currentDay.value.millisecondsSinceEpoch));
    _keyForm.currentState?.reset();
    Get.back(result: id);
  }

  List<Event> onCurrentEvent(DateTime date) =>
      _events.where((e) => DateTime.fromMillisecondsSinceEpoch(e.date ?? 0).isSameDay(date)).toList();

  void onSaveEvent() {
    if (_keyForm.currentState?.validate() == true) {
      _keyForm.currentState?.save();
    }
  }

  bool onHolidayPredicate(day) =>
      day.weekday == DateTime.sunday;

  onDeleteEvent(Event event) async {
    await _service.eventDao.deleteEvent(event);
    _events.remove(event);
    _focusedDay.refresh();
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    _currentDay.value = selectedDay;
  }

  onPageChanged(DateTime selectedDay) async {
    _start.value = DateTime(selectedDay.year, selectedDay.month, 1).millisecondsSinceEpoch;
    _end.value = DateTime(selectedDay.year, selectedDay.month + 1, 0, 23, 59, 59).millisecondsSinceEpoch;

    _events.clear();
    _events.addAll(await _service.eventDao.findAllByDate(_start.value, _end.value));

    _focusedDay.value = selectedDay;
  }

  onAddMemo() async {
    final id = await Get.toNamed(EventAddPage.routeName);
    if (id != null) {
      final event = await _service.eventDao.findById(id);
      if (event != null) {
        _events.add(event);
        _focusedDay.refresh();
      }
    }
  }

}