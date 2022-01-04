
import 'package:path/path.dart';
import 'package:savemoney/models/Transactions.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class TransactionDao{
  static const String _tableName = 'Transactions';
  static const String _id = 'id';
  static const String _typeId = 'typeId';
  static const String _name = 'name';
  static const String _value = 'value';
  //static const String _date = 'date';

  static const String tableSql = 'CREATE TABLE $_tableName ('
        '$_id INTEGER PRIMARY KEY, '
        '$_typeId INTEGER, '
        '$_name VARCHAR(100), '
        '$_value DECIMAL(9,2), '
        //'$_date DATETIME,'
        'FOREIGN KEY(typeId) REFERENCES TransactionType(id))';

  Future<int> save(Transactions transaction) async {
    final Database db = await getDatabase();
    Map<String, dynamic> transactionMap = _toMap(transaction);
    return db.insert(_tableName, transactionMap);
  }

  Map<String, dynamic> _toMap(Transactions transaction) {
    final Map<String, dynamic> transactionMap = Map();
    transactionMap[_typeId] = transaction.typeId;
    transactionMap[_name] = transaction.name;
    transactionMap[_value] = transaction.value;
    //transactionMap[_date] = transaction.date;
    return transactionMap;
  }

  Future<List<Transactions>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Transactions> caracters = _toList(result);
    return caracters;
  }

  List<Transactions> _toList(List<Map<String, dynamic>> result) {
    final List<Transactions> types = [];

    for (Map<String, dynamic> row in result) {
      final Transactions caracter = Transactions(
        row[_id],
        row[_typeId],
        row[_name],
        row[_value],
        //row[_date],
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