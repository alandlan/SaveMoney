import 'package:flutter/material.dart';
import 'package:savemoney/database/dao/transactiontype_dao.dart';
import 'package:savemoney/models/TransactionType.dart';

class TransactionTypeCreate extends StatefulWidget {
  const TransactionTypeCreate({Key? key}) : super(key: key);

  @override
  State<TransactionTypeCreate> createState() => _TransactionTypeCreateState();
}

class _TransactionTypeCreateState extends State<TransactionTypeCreate> {
  bool _credito = true;
  bool _debito = false;

  final TextEditingController _nameController = TextEditingController();
  final TransactionTypeDao _dao = TransactionTypeDao();

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome da Transação',
              ),
              style: TextStyle(fontSize: 16.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SwitchListTile(
                title: const Text('Crédito'),
                value: _credito,
                onChanged: (bool value) {
                  setState(() {
                    _debito = !_debito;
                    _credito = value;
                  });
                },
                secondary: const Icon(
                  Icons.arrow_circle_up,
                  color: Colors.green,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SwitchListTile(
                title: const Text('Débito'),
                value: _debito,
                onChanged: (bool value) {
                  setState(() {
                    _credito = !_credito;
                    _debito = value;
                  });
                },
                secondary: const Icon(
                  Icons.arrow_circle_down,
                  color: Colors.red,
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Create'),
              onPressed: () {
                final String name = _nameController.text;
                final int credito = _credito ? 1 : 0;

                final TransactionType newType =
                    TransactionType(0, name, credito);

                _dao
                    .save(newType)
                    .then((id) => Navigator.pop(context));
              },
            )
          ],
        ),
      ),
    );
  }
}
