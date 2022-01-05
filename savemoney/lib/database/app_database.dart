
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/transactionType_dao.dart';
import 'dao/transaction_dao.dart';

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
      db.execute(TransactionDao.tableSql);
    },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}