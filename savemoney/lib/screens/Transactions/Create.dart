import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:savemoney/database/dao/account_dao.dart';
import 'package:savemoney/database/dao/transactiontype_dao.dart';
import 'package:savemoney/models/Account.dart';
import 'package:savemoney/models/TransactionType.dart';
import 'package:savemoney/utils/dateToString.dart';

class TransactionsCreate extends StatefulWidget {
  const TransactionsCreate({Key? key}) : super(key: key);

  @override
  _TransactionsCreateState createState() => _TransactionsCreateState();
}

class _TransactionsCreateState extends State<TransactionsCreate> {
  final AccountDao accountDao = AccountDao();
  List<Account> accouts = [];

  final TransactionTypeDao typeDao = TransactionTypeDao();
  List<TransactionType> types = [];

  String _selectedDate = '';
  String _selectedAccount = '';
  String _selectedType = '';
  TextEditingController _selectedValue = TextEditingController();

  // @override
  // void initState() {
  //   accountDao.findAll().then((value) => accouts = value);
  //   typeDao.findAll().then((value) => types = value);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    //typeDao.save(TransactionType(0,"Salário",1));
    //accountDao.save(Account(0,"Corrente",0));

    accountDao.findAll().then((value) => accouts = value);
    typeDao.findAll().then((value) => types = value);

    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      setState(() {
        if (args.value is DateTime) {
          _selectedDate = dateToString(args.value, null);
        } else {
          _selectedDate = dateToString(DateTime.now(), null);
        }
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Nova transação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            DropdownButton<String>(
              hint: _selectedAccount.isEmpty
                  ? Text('Conta')
                  : Text(_selectedAccount),
              //value: _selectedAccount,
              isExpanded: true,
              iconSize: 30.0,
              items: accouts.map((Account value) {
                return DropdownMenuItem<String>(
                  value: value.name,
                  child: Text(value.name),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedAccount = newValue!;
                  //debugPrint(_selectedAccount);
                });
              },
            ),
            DropdownButton<String>(
              hint: _selectedType.isEmpty ? Text('Tipo') : Text(_selectedType),
              //hint: Text(_selectedType),
              isExpanded: true,
              iconSize: 30.0,
              items: types.map((TransactionType value) {
                return DropdownMenuItem<String>(
                  value: value.name,
                  child: Text(value.name),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedType = newValue!;
                  debugPrint(_selectedType);
                });
              },
            ),
            Container(
              child: TextField(
                controller: _selectedValue,
                decoration: new InputDecoration(hintText: 'Valor'),
                inputFormatters: <TextInputFormatter>[
                  CurrencyTextInputFormatter(
                    //turnOffGrouping: true,
                    locale: 'pt-BR',
                    decimalDigits: 2,
                    name: ''
                  ),
                ],
                keyboardType: TextInputType.number,
                 // Only numbers can be entered
              ),
            ),
            Container(
              child: SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.single,
              ),
            ),
          
            ElevatedButton(
              child: Text('Criar'),
              onPressed: () {
                final String account = _selectedAccount;
                final String type = _selectedType;
                final String date = _selectedDate;
                final String valor = _selectedValue.text;
                
                var converter = double.tryParse(valor.replaceAll('.', '').replaceAll(',', '.'));

                debugPrint(account);
                debugPrint(type);
                debugPrint(date);
                debugPrint(valor);
                debugPrint(converter.toString());
              },
            )
          ],
        ),
      ),
    );
  }
}
