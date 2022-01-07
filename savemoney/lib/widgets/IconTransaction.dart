import 'package:flutter/material.dart';

class IconTransaction extends StatelessWidget {
  final int credito;

  IconTransaction(this.credito);

  @override
  Widget build(BuildContext context) {
    if (credito == 1)
      return Icon(Icons.arrow_circle_up, color: Colors.green);
    else
      return Icon(Icons.arrow_circle_down, color: Colors.red);
  }
}
