import 'package:flutter/material.dart';

import 'package:savemoney/models/Transactions.dart';
import 'package:savemoney/screens/TransactionType/Index.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.green),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Save Money"),
          ),
          body: FutureBuilder(
            //future: _transactionDao.findAll(),
            builder: (context, snapshot) {
              List<Transactions> transactions = [];
              if (snapshot.hasData) {
                transactions = snapshot.data as List<Transactions>;
              }
              return ListView.builder(
                  itemBuilder: (context, index) {
                    final Transactions transaction = transactions[index];
                    return _TransactionItem(transaction);
                  },
                  itemCount: transactions.length);
            },
          ),
          drawer: Drawer(
              child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Alan Vieira Martins"),
                accountEmail: Text("alan4lann@gmail.com"),
                arrowColor: Colors.green,
                currentAccountPicture: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://media-exp1.licdn.com/dms/image/C4E03AQEarGWSsoOCzg/profile-displayphoto-shrink_400_400/0/1544907761843?e=1646870400&v=beta&t=3omSX6MvN0KJcmV4U-E7HgPxuzT2r2yJHVmWmNjeNGk'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              ListTile(
                  leading: Icon(Icons.payments),
                  title: Text("Transação"),
                  subtitle: Text("Consultar transações"),
                  //trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    debugPrint('toquei no drawer');
                  }),
              // ListTile(
              //   leading: Icon(Icons.attach_money),
              //   title: Text("Transação"),
              //   subtitle: Text("Cadastrar transação"),
              //   //trailing: Icon(Icons.arrow_forward),
              //   onTap: () {
              //     debugPrint('toquei no drawer');
              //   }
              //  ),
              ListTile(
                  leading: Icon(Icons.price_change_outlined),
                  title: Text("Tipo de Transação"),
                  subtitle: Text("Consultar tipo de Transação"),
                  //trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TransactionTypeIndex(),
                      ),
                    );
                  }),
              //  ListTile(
              //    leading: Icon(Icons.price_check_outlined),
              //    title: Text("Tipo de Transação"),
              //    subtitle: Text("Cadastrar tipo de Transação"),
              //    //trailing: Icon(Icons.arrow_forward),
              //   onTap: () {
              //     Navigator.pop(context);
              //   }
              //  )
            ],
          ))),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final Transactions transaction;

  _TransactionItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(transaction.name),
        subtitle: Text(transaction.value.toString()),
      ),
    );
  }
}
