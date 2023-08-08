import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_example/database/dao/event_dao.dart';
import 'package:flutter_example/database/dao/memo_dao.dart';
import 'package:flutter_example/model/entity/event.dart';
import 'package:flutter_example/model/entity/memo.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';


@Database(version: 1, entities: [Memo, Event])
abstract class ExampleDatabase extends FloorDatabase {
  MemoDao get memoDao;
  EventDao get eventDao;
}