import 'package:flutter/material.dart';
import 'package:reference_project_flutter/features/Social/social_icons/models/menu.dart';
import 'package:reference_project_flutter/features/Social/social_icons/widgets/clipper.dart';

// colors ---
const Color green = Color(0xff76984b);
const Color white = Color(0xffffffff);
const Color black = Color(0xff000000);
// textStyles ---
const TextStyle textButton =
TextStyle(color: white, fontSize: 16.0, fontWeight: FontWeight.w600);


class MenuBar extends StatefulWidget {
  const MenuBar({Key? key}) : super(key: key);

  @override
  State<MenuBar> createState() => _MenuBarState();

}

class _MenuBarState extends State<MenuBar> {
  int currentSelect = 0;

  @override
  Widget build(BuildContext context) {
    print(currentSelect);
    return Container(
      width: 85,
      color: green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i=0;i<menuItems.length;i++)
            menuButtons(
              name: menuItems[i].name,
              index: i,
              onClick: (){
                setState(()=> currentSelect = i);
                print(currentSelect);
              },
            ),
        ],
      ),
    );
  }

  Widget menuButtons({
    required String name , required int index , required Function() onClick
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: TextButton(
              onPressed: onClick,
              child: Text(
                name,
                style: textButton,
              ),
            ),
          ),
        ),
        currentSelect == index
            ? RotatedBox(
          quarterTurns: 2,
          child: ClipPath(
            clipper: CustomMenuClip(),
            child: Container(
              width: 35,
              height: 110,
              color: white,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: green,
                  radius: 3,
                ),
              ),
            ),
          ),
        )
            : SizedBox(
          width: 35,
          height: 110,
        ),
      ],
    );
  }

}
