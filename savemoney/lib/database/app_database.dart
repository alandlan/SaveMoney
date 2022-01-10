
import 'package:path/path.dart';
import 'package:savemoney/database/dao/account_dao.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/transactionType_dao.dart';
import 'dao/transactions_dao.dart';

//Criar banco. Função para criar o banco de dados;

Future<void> dropDatabase() async {
  var path = await getDatabasesPath();
  await ((await openDatabase(path)).close());
  await deleteDatabase(path); 
}

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'savemoney.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(TransactionTypeDao.tableSql);
      db.execute(AccountDao.tableSql);
      db.execute(TransactionsDao.tableSql);
    },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}

Future<void> dropTables() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'savemoney.db');

  Database database = await openDatabase(
    path,
    version: 1,
    onOpen: (db) {
      db.rawQuery('DROP TABLE Account');
      db.rawQuery('DROP TABLE Transactions');
      db.rawQuery('DROP TABLE TransactionType');
    },
  );

  await database.close();
}