import 'package:flutter/material.dart';
import 'package:savemoney/database/dao/transactionType_dao.dart';
import 'package:savemoney/database/dao/transaction_dao.dart';

import 'package:savemoney/models/TransactionType.dart';
import 'package:savemoney/models/Transactions.dart';
import 'package:sqflite/sqflite.dart';

class ResumePage extends StatelessWidget {

  final TransactionTypeDao _dao = TransactionTypeDao();
  final TransactionDao _dao2 = TransactionDao();

  final List<Transactions> transactions = [];

  @override
  Widget build(BuildContext context) {

    _dao.save(TransactionType(0,"Salario",1));
  
    //_dao.findAll().then((value) => { value.map((e) => print(e.name)) });

    _dao2.save(Transactions(0,1,"Janeiro",1000.0));

    //_dao2.findAll().then((value) => { value.map((e) => print(e.name)) });
    
    transactions.add(Transactions(0,1,"Teste",1000));
    transactions.add(Transactions(0,1,"Teste",1000));
    transactions.add(Transactions(0,1,"Teste",1000));
    transactions.add(Transactions(0,1,"Teste",1000));
    transactions.add(Transactions(0,1,"Teste",1000));
    transactions.add(Transactions(0,1,"Teste",1000));
    transactions.add(Transactions(0,1,"Teste",1000));
    transactions.add(Transactions(0,1,"Teste",1000));
    transactions.add(Transactions(0,1,"Teste",1000));
    transactions.add(Transactions(0,1,"Teste",1000));
    transactions.add(Transactions(0,1,"Teste",1000));
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Save Money"),
        
      ),body: ListView.builder(
        itemBuilder: (context,index){
          final Transactions transaction = transactions[index];
          return _TransactionItem(transaction);
        },
        itemCount: transactions.length,
      ),
    );
  }

}

class _TransactionItem extends StatelessWidget {

  final Transactions transaction;

  _TransactionItem(this.transaction);

  @override
  Widget build(BuildContext context){
    return Card(
      child: ListTile(
        title: 
          Text(transaction.name),
        subtitle:
          Text(transaction.value.toString()) ,
      ),
    );
  }
}