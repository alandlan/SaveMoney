import 'package:flutter/material.dart';
import 'database/dao/transaction_dao.dart';
import 'models/Transactions.dart';
import 'screens/splash.dart';

void main() {
  //final TransactionDao _transactionDao = TransactionDao();
  //_transactionDao.save(Transactions(0,1,'Janeiro',1000.0,"2021-01-01"));
  runApp(const SaveMoneyApp());  
}

