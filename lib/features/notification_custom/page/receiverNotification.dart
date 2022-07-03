import 'package:flutter/material.dart';

class ReceiverNotification extends StatelessWidget {
  const ReceiverNotification({Key? key,required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ReceiverNotification'),
      ),
      body: Center(
        child: Text(text),
      ),
    );
  }
}
