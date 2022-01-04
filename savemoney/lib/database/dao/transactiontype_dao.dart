// ignore_for_file: file_names

import 'package:path/path.dart';
import 'package:savemoney/models/TransactionType.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class TransactionTypeDao {

  static const String _tableName = 'TransactionType';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _credit = 'credit';

  static const String tableSql = 'CREATE TABLE $_tableName ('
      '$_id INTEGER PRIMARY KEY, '
      '$_name VARCHAR(100), '
      '$_credit BOOLEAN)'; 

  Future<int> save(TransactionType type) async {
    final Database db = await getDatabase();
    Map<String, dynamic> typeMap = _toMap(type);
    return db.insert(_tableName, typeMap);
  }

  Map<String, dynamic> _toMap(TransactionType type) {
    final Map<String, dynamic> typeMap = Map();
    typeMap[_name] = type.name;
    typeMap[_credit] = type.credit;
    return typeMap;
  }

  Future<List<TransactionType>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<TransactionType> caracters = _toList(result);
    return caracters;
  }

  List<TransactionType> _toList(List<Map<String, dynamic>> result) {
    final List<TransactionType> types = [];

    for (Map<String, dynamic> row in result) {
      final TransactionType caracter = TransactionType(
        row[_id],
        row[_name],
        row[_credit]
      );
      types.add(caracter);
    }
    return types;
  }

  Future<void> removeAll() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'savemoney.db');

    Database database = await openDatabase(
      path,
      version: 1,
      onOpen: (db) {
        db.rawQuery('DELETE FROM $_tableName');
      },
    );

    await database.close();
  }
}
