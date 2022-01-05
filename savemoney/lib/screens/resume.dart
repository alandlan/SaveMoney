import 'package:flutter/material.dart';
import 'package:savemoney/database/dao/transaction_dao.dart';

import 'package:savemoney/models/Transactions.dart';

class ResumePage extends StatelessWidget {

  final TransactionDao _transactionDao = TransactionDao();
  
  @override
  Widget build(BuildContext context) {

    //_transactionDao.save(Transactions(0,1,'Janeiro',1000.0,"2021-01-01"));

    return Scaffold(
      appBar: AppBar(
        title: Text("Save Money"),        
      ),
      body: FutureBuilder(
        future: _transactionDao.findAll(),
        builder: (context,snapshot) {
          List<Transactions> transactions = [];
          if(snapshot.hasData){ transactions = snapshot.data as List<Transactions>;}
          return ListView.builder(
            itemBuilder: (context,index){
              final Transactions transaction = transactions[index];
              return _TransactionItem(transaction);
            },
            itemCount: transactions.length
          );
        },
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