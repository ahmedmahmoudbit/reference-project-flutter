import 'package:flutter/material.dart';

class ShoNotificationData extends StatelessWidget {
  const ShoNotificationData({Key? key,required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 100,
          width: 100,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
             color: Colors.redAccent,
           ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(text),
              Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
