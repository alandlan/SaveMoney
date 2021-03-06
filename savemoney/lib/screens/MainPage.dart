import 'package:flutter/material.dart';
import 'package:savemoney/database/app_database.dart';
import 'package:savemoney/database/dao/account_dao.dart';
import 'package:savemoney/models/Account.dart';

import 'package:savemoney/screens/Account/Index.dart';
import 'package:savemoney/screens/Transactions/Index.dart';
import 'package:savemoney/widgets/loading.dart';
import 'package:savemoney/widgets/withOutData.dart';

import 'TransactionType/Index.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AccountDao _dao = AccountDao();

  @override
  Widget build(BuildContext context) {
    //dropTables().then((value) => debugPrint('Deletou'));

    _dao.findAll().then((value) => debugPrint(value.toString()));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.green),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Dashboard Save Money"),
          ),
          body: RefreshIndicator(
            onRefresh: refreshList,
            child: FutureBuilder<List<Account>>(
              initialData: [],
              future: _dao.findAll(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    break;
                  case ConnectionState.waiting:
                    return Loading();
                  case ConnectionState.active:
                    break;
                  case ConnectionState.done:
                    if (snapshot.data != null) {
                      final List<Account> types = snapshot.data as List<Account>;
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final Account type = types[index];
                          return _AccountItem(type);
                        },
                        itemCount: types.length,
                      );
                    }
                    return WithOutData("Sem fundos!");
                }
          
                return Text("Erro");
              },
            ),
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
                  leading: Icon(Icons.account_balance_outlined),
                  title: Text("Saldos"),
                  subtitle: Text("Consultar saldos"),
                  //trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AccountIndex(),
                      ),
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.payments),
                  title: Text("Transa????o"),
                  subtitle: Text("Consultar transa????es"),
                  //trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TransactionsIndex(),
                      ),
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.price_change_outlined),
                  title: Text("Tipo de Transa????o"),
                  subtitle: Text("Consultar tipo de Transa????o"),
                  //trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TransactionTypeIndex(),
                      ),
                    );
                  }),
                ListTile(
                  leading: Icon(Icons.restore_from_trash),
                  title: Text("Limpar Dados"),
                  subtitle: Text("Limpa todos os dados."),
                  //trailing: Icon(Icons.arrow_forward),
                  onTap: () async {
                    
                    debugPrint('drop');
                    await deleteTables();
                    //debugPrint('delay');
                    // Future.delayed(Duration(seconds: 5), () => {
                      
                      
                    //   getDatabase()
                    // });
                    
                    debugPrint('fim');


                  }),
            ],
          ))),
    );
  }

  Future<void>  refreshList() async {
    Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c) => MainPage(),transitionDuration: Duration(seconds: 0)));
  }
}

class _AccountItem extends StatelessWidget {
  final Account account;
  _AccountItem(this.account);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(account.name),
        subtitle: Text("Saldo: "+ account.balance.toStringAsFixed(2)),
        trailing: Icon(
          Icons.attach_money,
          color: Colors.green,
        ),
      ),
    );
  }
}