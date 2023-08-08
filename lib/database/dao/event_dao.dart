import 'package:floor/floor.dart';
import 'package:flutter_example/model/entity/event.dart';

@dao
abstract class EventDao {
  @Query('SELECT COUNT(id) FROM event')
  Future<int?> count();

  @Query('SELECT * FROM event WHERE id = :id')
  Future<Event?> findById(int id);

  @Query('SELECT * FROM event WHERE date BETWEEN :start AND :end')
  Future<List<Event>> findAllByDate(int start, int end);
  
  @insert
  Future<int> insertEvent(Event event);
  
  @update
  Future<void> updateEvent(Event event);

  @update
  Future<void> updateEvents(List<Event> events);

  @delete
  Future<void> deleteEvent(Event event);
}