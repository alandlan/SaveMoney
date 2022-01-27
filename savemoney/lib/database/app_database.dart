
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:savemoney/database/dao/account_dao.dart';
import 'package:savemoney/database/dao/transactions_dao.dart';
import 'package:savemoney/database/dao/transactiontype_dao.dart';
import 'package:sqflite/sqflite.dart';


//Criar banco. Função para criar o banco de dados;

Future<void> dropDatabase() async {
  var path = await getDatabasesPath();
  await ((await openDatabase(path)).close());
  await deleteDatabase(path); 
}

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'savemoney.db');

  debugPrint("Criando tabelas");

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

Future<Database> deleteTables() async {
  final String path = join(await getDatabasesPath(), 'savemoney.db');

  debugPrint("Deletando tabelas");

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(TransactionTypeDao.deleteTable);
      db.execute(TransactionsDao.deleteTable);
      db.execute(AccountDao.deleteTable);
    },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}

Future<void> dropTables() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'savemoney.db');

  debugPrint("Limpando tabelas");

  Database database = await openDatabase(
    path,
    version: 1,
    onOpen: (db) {
    //   db.rawDelete('Account');
    //   db.rawDelete('Transactions');
    //   db.rawDelete('TransactionType');
    //   db.close();
     },

  );

  database.execute('DELETE FROM TransactionType DELETE FROM Transactions DELETE FROM Account');
  //database.execute('');
  //database.execute('');

  await database.close();
}