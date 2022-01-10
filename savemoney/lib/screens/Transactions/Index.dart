import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:savemoney/database/dao/transactions_dao.dart';
import 'package:savemoney/models/Transactions.dart';
import 'package:savemoney/screens/Transactions/Create.dart';
import 'package:savemoney/widgets/IconTransaction.dart';
import 'package:savemoney/widgets/withOutData.dart';

class TransactionsIndex extends StatefulWidget {
  const TransactionsIndex({Key? key}) : super(key: key);

  @override
  _TransactionsIndexState createState() => _TransactionsIndexState();
}

class _TransactionsIndexState extends State<TransactionsIndex> {

  final TransactionsDao _dao =  TransactionsDao();

  @override
  Widget build(BuildContext context) {

    //_dao.save(Transactions(0,"Salário",1000,"Corrente",dateString));

    //_dao.findAll().then((value) => debugPrint(value.toString()));

    return Scaffold(
      appBar: AppBar(title: Text("Transações")),
      body: FutureBuilder<List<Transactions>>(
        initialData: [],
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CircularProgressIndicator(), Text("Aguarde...")],
                ),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if(snapshot.data != null){
                final List<Transactions> transactions =
                    snapshot.data as List<Transactions>;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Transactions transaction = transactions[index];
                    return _Transaction(transaction);
                  },
                  itemCount: transactions.length,
                );
              }
              return WithOutData("Sem transações!"); 
              
          }

          return Text("Erro");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => TransactionsCreate(),
              ))
              .then((value) => setState(() {}));
        },
        child: Icon(Icons.plus_one),
      ),
    );
  }
}

class _Transaction extends StatelessWidget {
  final Transactions transaction;
  _Transaction(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(transaction.type),
        subtitle: Text('Valor: '+transaction.value.toString()+ ' Data: '+transaction.dateTransaction.toString()),
        trailing: IconTransaction(transaction.value < 0 ? false : true),
      ),
    );
  }
}