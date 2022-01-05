// ignore: file_names
import 'package:flutter/material.dart';

class TransactionTypeIndex extends StatelessWidget {
  const TransactionTypeIndex({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tipo de Transações")),
      body: ListView(
        children: <Widget>[
          Card(child: ListTile(
            title: Text('Salário'),
            subtitle: Text('Crédito'),
            trailing: Icon(Icons.arrow_upward_sharp,color: Colors.green),
            ),
          ),
          Card(child: ListTile(
            title: Text('MEI'),
            subtitle: Text('Débito'),
            trailing: Icon(Icons.arrow_downward_sharp,color: Colors.red),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.plus_one),
      ),
    );
  }
}