import 'package:flutter/material.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
