import 'package:flutter/material.dart';

class WithOutData extends StatelessWidget {
  
  final String text;

  WithOutData(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search_off),
          Text(text)],
      ),
    );
  }
}