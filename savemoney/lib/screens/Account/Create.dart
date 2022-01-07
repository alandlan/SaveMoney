
import 'package:flutter/material.dart';
import 'package:savemoney/database/dao/account_dao.dart';
import 'package:savemoney/models/Account.dart';

class AccountCreate extends StatefulWidget {
  const AccountCreate({Key? key}) : super(key: key);

  @override
  State<AccountCreate> createState() => _AccountCreateState();
}

class _AccountCreateState extends State<AccountCreate> {
  final TextEditingController _nameController = TextEditingController();

  final AccountDao _dao = AccountDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar fundos!"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome da Conta',
              ),
              style: TextStyle(fontSize: 16.0),
            ),
            ElevatedButton(
              onPressed: () {
                final String nome = _nameController.text;
                final Account account = Account(0, nome, 0.0);
                _dao.save(account).then((id) => Navigator.pop(context));
              },
              child: Text('Criar'),
            )
          ],
        ),
      ),
    );
  }
}
