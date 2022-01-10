

import 'package:flutter/material.dart';
import 'package:savemoney/database/dao/account_dao.dart';
import 'package:savemoney/database/dao/transactions_dao.dart';
import 'package:savemoney/database/dao/transactiontype_dao.dart';
import 'package:savemoney/models/Account.dart';
import 'package:savemoney/models/TransactionType.dart';
import 'package:savemoney/models/Transactions.dart';

class TransactionsService{
  
  AccountDao _accountDao = AccountDao();
  TransactionsDao _transactionsDao = TransactionsDao();
  TransactionTypeDao _transactionTypeDao = TransactionTypeDao();

  Future<Transactions> save (Transactions transaction) async {

    TransactionType type = await _transactionTypeDao.findByName(transaction.type);
    Account account = await _accountDao.findByName(transaction.account);

    if(type.credit != 1){
      account.balance = transaction.value * -1;
    }else{
      account.balance = account.balance + transaction.value;
    }

    //debugPrint(account.toString());
    //debugPrint(transaction.toString());

    //await _transactionsDao.save(transaction);
    await _accountDao.updateBalance(account);

    return transaction;
  }
}