
import 'package:savemoney/database/app_database.dart';
import 'package:savemoney/models/Account.dart';
import 'package:sqflite/sqflite.dart';

class AccountDao{
  static const String _tableName = 'Account';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _balance = 'balance';

  static const String tableSql = 'CREATE TABLE $_tableName ('
    '$_id INTEGER PRIMARY KEY, '
    '$_name VARCHAR(100), '
    '$_balance DECIMAL(9,2) )';

  Map<String, dynamic> _toMap(Account account){
    final Map<String, dynamic> accountMap = Map();
    accountMap[_name] = account.name;
    accountMap[_balance] = account.balance;
    return accountMap;
  } 

  List<Account> _toList(List<Map<String,dynamic>> result){
    final List<Account> accounts = [];

    for(Map<String,dynamic> row in result){
      final Account account = Account(
        row[_id],
        row[_name],
        getDouble(row[_balance])
      );
      accounts.add(account);
    }
    return accounts;
  }

  static double getDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      return value.toDouble();
    }
  }


  Future<int> save(Account account) async{
    final Database db = await getDatabase();
    Map<String, dynamic> accountMap = _toMap(account);
    return db.insert(_tableName, accountMap);
  }

  Future<List<Account>> findAll() async{
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Account> accounts = _toList(result);
    return accounts;
  }
}