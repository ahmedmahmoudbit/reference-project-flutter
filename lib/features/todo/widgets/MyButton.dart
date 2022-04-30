import 'package:flutter/material.dart';
import 'package:reference_project_flutter/core/constants.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key,required this.inTap , required this.label}) : super(key: key);
  final String label;
  final Function() inTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: inTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryClr
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
