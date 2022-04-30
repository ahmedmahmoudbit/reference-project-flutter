import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reference_project_flutter/core/constants.dart';
import 'package:reference_project_flutter/core/cubit/cubit.dart';
import 'package:reference_project_flutter/core/cubit/state.dart';
import 'package:reference_project_flutter/features/todo/data/model.dart';
import 'package:reference_project_flutter/features/todo/ui/home/HomePageTodo.dart';
import 'package:reference_project_flutter/features/todo/widgets/MyButton.dart';
import 'package:reference_project_flutter/features/todo/widgets/MyInputField.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController =TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:48 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  int _selectedRemind = 5;
  int _selectedColor = 0;
  List<int> remindList = [
  5,
  10,
  15,
  20,
  ];

  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        var cubit = MainBloc.get(context);
        return Scaffold(
          appBar: buildAppBar(context, cubit),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyInputField(
                  title: 'Title',
                  hint: 'Enter yot title',
                  controller: titleController,
                ),
                MyInputField(
                  title: 'Note',
                  hint: 'Enter yot note',
                  controller: noteController,
                ),
                MyInputField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    icon: const Icon(Icons.calendar_today_outlined,
                    color: Colors.grey,),
                    onPressed: (){
                      getDateFromUser();
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyInputField(title: 'Start Time',
                        hint: _startTime,
                        widget: IconButton(icon: const Icon(Icons.access_time_rounded,color: Colors.grey),onPressed: (){
                          _getTimeFromUser(isStart: true);
                        },),),
                    ),
                    Expanded(
                      child: MyInputField(title: 'End Time',
                        hint: _endTime,
                        widget: IconButton(icon: const Icon(Icons.access_time_rounded,color: Colors.grey,),onPressed: (){
                          _getTimeFromUser(isStart: false);
                        },),),
                    ),
                  ],
                ),
                MyInputField(
                  title: 'Remainder',
                  hint: 'Remind $_selectedRemind minutes early',
                  widget: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down,
                    color: Colors.grey,
                    ),
                    underline: Container(height: 0,),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRemind = int.parse(newValue!);
                      });
                    },
                    iconSize: 32,
                    elevation: 4,
                    style: bodyStyle,
                    items: remindList.map<DropdownMenuItem<String>>((int value ){
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ),
                MyInputField(
                  title: 'Repeat',
                  hint: _selectedRepeat,
                  widget: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedRepeat = newValue.toString();
                      });
                    },
                    iconSize: 32,
                    elevation: 4,
                    style: bodyStyle,
                    underline: Container(height: 0,),
                    items: repeatList.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: const TextStyle(color: Colors.grey),),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildColor(),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 15.0 , end: 15.0),
                      child: MyButton(inTap: (){
                        _validateData();
                      }, label: "Create Task"),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Column buildColor() {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20),
                      child: Text('Colors',
                        style: titleStyle,),
                    ),
                    SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 15),
                      child: Wrap(
                        children: List<Widget>.generate(
                            3,
                                (index){
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _selectedColor = index;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(start: 6.0),
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor:
                                    index == 0 ? primaryClr : index == 1 ? pinkClr : yellowClr,
                                    child: _selectedColor == index ?
                                    Icon(Icons.done_rounded , color: Colors.white, size: 20,) : Container(),
                                  ),),
                              );
                            }),
                      ),
                    )
                  ],
                );
  }

  _validateData() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      _addTaskToDb();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomePageTodo()));
      Navigator.pop(context);
    } else if (titleController.text.isEmpty || noteController.text.isEmpty) {
        print('title Or note is Empty');
    } else {
      print('please check data .');
    }
  }

  _addTaskToDb() async {
     await MainBloc.get(context).addTask(
        task: TaskModel(
        note: noteController.text,
        title: titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
        color: _selectedColor,
        isCompleted: 0
    )
   );
  }

  AppBar buildAppBar(BuildContext context, MainBloc cubit) {
    return AppBar(
      title: const Text('Add Task',
      style: TextStyle(
        fontSize: 20,
        color: Colors.white
      ),),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios_rounded,
          size: 20,),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.person),
        ),
      ],

    );
  }

  getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2050));
    if (pickerDate != null) {
     setState(() {
       _selectedDate = pickerDate;
       print(_selectedDate);
     });
    } else {
      print("it's null or something is wrong");
    }
  }

  _getTimeFromUser  ({
    required bool isStart
}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime==null) {
      print('Time canceld');
    } else if (isStart==true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStart==false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
}

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0])),
    );
  }
}
