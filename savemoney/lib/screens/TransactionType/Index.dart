import 'package:flutter/material.dart';
import 'package:savemoney/database/dao/transactiontype_dao.dart';
import 'package:savemoney/models/TransactionType.dart';
import 'package:savemoney/screens/TransactionType/Create.dart';
import 'package:savemoney/widgets/IconTransaction.dart';

class TransactionTypeIndex extends StatefulWidget {

  @override
  State<TransactionTypeIndex> createState() => _TransactionTypeIndexState();
}

class _TransactionTypeIndexState extends State<TransactionTypeIndex> {
  final TransactionTypeDao _dao = TransactionTypeDao();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Tipo de Transações")),
      body: FutureBuilder<List<TransactionType>>(
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
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              //if (snapshot.data != null) {
              final List<TransactionType> types =
                  snapshot.data as List<TransactionType>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final TransactionType type = types[index];
                  return _TransactionTypeItem(type);
                },
                itemCount: types.length,
              );
              // }else{
              //   return Center(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [Text("Nenhum item encontrado!")],
              //     ),
              //   );
              // }

              break;
          }

          return Text("Erro");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => TransactionTypeCreate(),
              ))
              .then((value) => setState(() {}));
        },
        child: Icon(Icons.plus_one),
      ),
    );
  }
}

class _TransactionTypeItem extends StatelessWidget {
  final TransactionType type;
  _TransactionTypeItem(this.type);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(type.name),
        subtitle: Text(type.credit == 1 ? 'Crédito' : 'Débito'),
        trailing: IconTransaction(type.credit == 1 ? true : false),
      ),
    );
  }
}
