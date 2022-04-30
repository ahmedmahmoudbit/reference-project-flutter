import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reference_project_flutter/core/constants.dart';
import 'package:reference_project_flutter/core/cubit/cubit.dart';
import 'package:reference_project_flutter/core/cubit/state.dart';

class MyInputField extends StatelessWidget {

   MyInputField({Key? key,
    required this.title,
    required this.hint,
     this.widget,
     this.controller,
})
      : super(key: key);

  final String title;
  final String hint;
   TextEditingController? controller;
   Widget? widget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 5),
                child: Text(
                  title,
                  style: titleStyle,
                ),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsetsDirectional.only(start: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey,
                      width: 1.0
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly:  widget==null?false:true,
                        autofocus: false,
                        controller: controller,
                        cursorColor: MainBloc.get(context).isDark ? Colors.grey[100] : Colors.grey,
                        style: subHeadingStyle2,
                        decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: bodyStyle,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 0
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0
                            ),
                          ),
                        ),
                      ),
                    ),
                    widget==null?Container():Container(child: widget,),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
