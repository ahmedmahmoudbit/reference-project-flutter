import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:reference_project_flutter/core/constants.dart';
import 'package:reference_project_flutter/core/cubit/cubit.dart';
import 'package:reference_project_flutter/core/cubit/state.dart';
import 'package:reference_project_flutter/features/todo/data/model.dart';
import 'package:reference_project_flutter/features/todo/ui/add_task/addTask.dart';
import 'package:reference_project_flutter/features/todo/widgets/MyButton.dart';
import 'package:reference_project_flutter/features/todo/widgets/MyTaskHome.dart';

class HomePageTodo extends StatefulWidget {
  const HomePageTodo({Key? key}) : super(key: key);

  @override
  State<HomePageTodo> createState() => _HomePageTodoState();
}

class _HomePageTodoState extends State<HomePageTodo> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    MainBloc.get(context).initalizeNotification(context);
    MainBloc.get(context).requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        var cubit = MainBloc.get(context);
        var size = MediaQuery.of(context).size;
        return Scaffold(
          appBar: buildAppBar(context, cubit),
          body: Column(
            children: [
              buildTaskBar(),
              buildTimeDate(size),
              const SizedBox(
                height: 10,
              ),
              _showTasks(cubit),
            ],
          ),
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context, MainBloc cubit) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          MainBloc.get(context).changeDarkMode();
        },
        child: const Icon(
          Icons.nightlight_round,
          size: 20,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.person),
        ),
      ],
    );
  }

  Container buildTimeDate(Size size) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 20, start: 20),
      child: DatePicker(
        DateTime.now(),
        height: size.height * 0.12,
        width: size.width * 0.17,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey)),
        monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
        onDateChange: (date) {
          setState(() {
            selectedDate = date;
          });
        },
      ),
    );
  }

  Container buildTaskBar() {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: subHeadingStyle2,
              ),
              Text(
                'Today',
                style: subHeadingStyle,
              ),
            ],
          ),
          MyButton(
            inTap: () {
              navigateTo(context, const AddTaskPage());
              MainBloc.get(context).getTask();
            },
            label: '+ Add Task',
          ),
        ],
      ),
    );
  }

  _showTasks(MainBloc cubit) {
    return Expanded(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: MainBloc.get(context).taskList.length,
          itemBuilder: (context, index) {
            var task = MainBloc.get(context).taskList[index];
            if (task.repeat == 'Daily') {
              DateTime date = DateFormat.jm().parse(task.startTime.toString());
              var myTime = DateFormat("HH:mm").format(date);
              cubit.scheduledNotification(
              int.parse(myTime.toString().split(":")[0]),
              int.parse(myTime.toString().split(":")[1]),
              task,
              );
              return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(
                              context: context, task: task, cubit: cubit);
                        },
                        child:
                            MyTaskHome(task),
                      ),
                    ],
                  ),
                ),
              ),
            );
            }
            if (task.date==DateFormat.yMd().format(selectedDate)) {
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(
                                context: context, task: task, cubit: cubit);
                          },
                          child:
                          MyTaskHome(task),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }

  _showBottomSheet(
      {required BuildContext context,
      required TaskModel task,
      required MainBloc cubit}) {
    var size = MediaQuery.of(context).size;

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(top: 4),
          height:
              task.isCompleted == 1 ? size.height * 0.24 : size.height * 0.32,
          color: cubit.isDark ? darkGreyClr : Colors.white,
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: cubit.isDark ? Colors.grey[600] : Colors.grey[300],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    task.isCompleted == 1
                        ? Container()
                        : _bottomSheet(
                            clr: primaryClr,
                            context: context,
                            label: 'Task Completed',
                            onTap: () {
                              MainBloc.get(context).markTaskCompleted(task.id!);
                              Navigator.pop(context);
                            },
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    _bottomSheet(
                      clr: Colors.red[300]!,
                      context: context,
                      label: 'Delete Task',
                      onTap: () {
                        cubit.delete(task: task);
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _bottomSheet(
                      clr: Colors.red[300]!,
                      context: context,
                      label: 'Close',
                      isClose: true,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _bottomSheet({
    required String label,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          // Border .
          border: Border.all(
            width: 2,
            color: isClose
                ? MainBloc.get(context).isDark
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style:
                isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
