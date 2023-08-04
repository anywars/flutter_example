import 'package:floor/floor.dart';
import 'package:flutter_example/model/entity/memo.dart';

@dao
abstract class MemoDao {
  @Query('SELECT COUNT(id) FROM memo')
  Future<int?> count();

  @Query('SELECT * FROM memo WHERE id = :id')
  Future<Memo?> findById(int id);

  @Query('SELECT * FROM memo ORDER BY sort ASC')
  Stream<List<Memo>> findAllAsStream();
  
  @insert
  Future<void> insertMemo(Memo memo);
  
  @update
  Future<void> updateMemo(Memo memo);

  @update
  Future<void> updateMemos(List<Memo> memo);

  @delete
  Future<void> deleteMemo(Memo memo);
}