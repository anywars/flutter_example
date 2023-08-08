import 'package:flutter/material.dart';
import 'package:flutter_example/common/date_time.dart';
import 'package:flutter_example/controller/calendar_controller.dart';
import 'package:flutter_example/model/entity/event.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends GetView<CalendarController> {
  static final routeName = '/calendar';


  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: Column(
      children: [
        Obx(() => TableCalendar(
          firstDay: controller.firstDay,
          lastDay: controller.lastDay,
          focusedDay: controller.focusedDay,
          currentDay: controller.currentDay,
          holidayPredicate: controller.onHolidayPredicate,
          locale: Get.deviceLocale?.toLanguageTag(),
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            holidayTextStyle: GoogleFonts.adamina(
              color: Colors.red,
              fontWeight: FontWeight.w700,
            ),
            holidayDecoration: BoxDecoration(),
            defaultTextStyle: GoogleFonts.adamina(),
            markerDecoration: BoxDecoration(
              color: Colors.lightBlue,
              shape: BoxShape.circle,
            ),
            markerSize: 5,
          ),
          eventLoader: controller.onCurrentEvent,
          onDaySelected: controller.onDaySelected,
          onPageChanged: controller.onPageChanged,
        )),


        Obx(() => Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            itemBuilder: (_, index) => Slidable(
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    backgroundColor: Colors.red ,
                    icon: Icons.delete,
                    label: 'Delete',
                    onPressed: (_) => controller.onDeleteEvent(controller.todayEvents[index])
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                title: Text(controller.todayEvents[index].memo ?? '')
              )
            ),
            separatorBuilder: (_, index) => Divider(),
            itemCount: controller.todayEvents.length,
          ),
        )),
      ],
    ),


  floatingActionButton: FloatingActionButton(
    onPressed: controller.onAddMemo,
    child: Icon(Icons.add),
  ));
}