import 'package:flutter/material.dart';
import 'package:savemoney/database/dao/account_dao.dart';
import 'package:savemoney/models/Account.dart';
import 'package:savemoney/screens/Account/Create.dart';
import 'package:savemoney/widgets/loading.dart';
import 'package:savemoney/widgets/withOutData.dart';

class AccountIndex extends StatefulWidget {
  const AccountIndex({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<AccountIndex> {
  final AccountDao _dao = AccountDao();

  @override
  Widget build(BuildContext context) {

    //_dao.findAll().then((value) => debugPrint(value.toString()));

    return Scaffold(
      appBar: AppBar(title: Text("Tipo de Contas")),
      body: FutureBuilder<List<Account>>(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => AccountCreate(),
              ))
              .then((value) => setState(() {}));
        },
        child: Icon(Icons.plus_one),
      ),
    );
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
