
import 'package:path/path.dart';
import 'package:savemoney/models/Transactions.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class TransactionsDao{
  static const String _tableName = 'Transactions';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _value = 'value';
  //static const String _type = 'type';
  static const String _account = 'account';
  static const String _dateTransaction = 'dateTransaction';

  static const String tableSql = 'CREATE TABLE $_tableName ('
        '$_id INTEGER PRIMARY KEY, '
        '$_name VARCHAR(100), '
        '$_value DECIMAL(9,2), '
        //'$_type VARCHAR(100), '
        '$_account VARCHAR(100), '
        '$_dateTransaction DATETIME )';

  Future<int> save(Transactions transaction) async {
    final Database db = await getDatabase();
    Map<String, dynamic> transactionMap = _toMap(transaction);
    return db.insert(_tableName, transactionMap);
  }

  Map<String, dynamic> _toMap(Transactions transaction) {
    final Map<String, dynamic> transactionMap = Map();
    transactionMap[_name] = transaction.name;
    transactionMap[_value] = transaction.value;
    //transactionMap[_type] = transaction.type;
    transactionMap[_account] = transaction.account;
    transactionMap[_dateTransaction] = transaction.dateTransaction;
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
        row[_name],
        getDouble(row[_value]),
        //row[_type],
        row[_account],
        row[_dateTransaction],
      );
      types.add(caracter);
    }
    return types;
  }

  static double getDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      return value.toDouble();
    }
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