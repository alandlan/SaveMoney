
import 'package:flutter/material.dart';

class TransactionTypeCreate extends StatefulWidget {
  const TransactionTypeCreate({ Key? key }) : super(key: key);

  @override
  State<TransactionTypeCreate> createState() => _TransactionTypeCreateState();
}

class _TransactionTypeCreateState extends State<TransactionTypeCreate> {
  List<bool> isSelected = [true,false];

  @override
  void initState() {
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Tipo"),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Nome da Transação',
            ),
            style: TextStyle(fontSize: 16.0),
          ),
          ToggleButtons(
            //fillColor: Colors.amberAccent,
            children: <Widget>[
              Icon(Icons.arrow_upward,color: Colors.green,),
              Icon(Icons.arrow_downward,color: Colors.red),
            ],
            isSelected: isSelected,
            onPressed: (int index) {
              setState(() {
              for (int indexBtn = 0;indexBtn < isSelected.length;indexBtn++) {
                if (indexBtn == index) {
                  isSelected[indexBtn] = true;
                } else {
                  isSelected[indexBtn] = false;
                }
              }
            });
          },
        )
      ],),
    );
  }

}