import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reference_project_flutter/core/constants.dart';
import 'package:reference_project_flutter/features/Social/social_icons/pages/socialIconPage.dart';
import 'package:rive/rive.dart';

class SocialPAge extends StatefulWidget {
  const SocialPAge({Key? key}) : super(key: key);

  @override
  State<SocialPAge> createState() => _SocialPAgeState();
}

class _SocialPAgeState extends State<SocialPAge> with TickerProviderStateMixin {
  List<SMIInput<bool>?> inputs = [];
  List<Artboard> artboards = [];
  List<String> assetPaths = [
    "assets/riv/fire.riv",
    "assets/riv/land.riv",
    "assets/riv/mediation.riv",
    "assets/riv/composer.riv",
    "assets/riv/profile.riv",
  ];

  int currentActiveIndex = 0;

  initializeArtboard() async {
    for (var path in assetPaths) {
      final data = await rootBundle.load(path);

      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      final controller =
      StateMachineController.fromArtboard(artboard, "State Machine 1");
      SMIInput<bool>? input;
      if (controller != null) {
        artboard.addController(controller);
        input = controller.findInput<bool>("status");
        input!.value = true;
      }
      inputs.add(input!);
      artboards.add(artboard);
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await initializeArtboard();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03123D),
      body: SafeArea(
        child: Column(
          children: [
            space10Vertical,
            Text(' 1 - is ',style: TextStyle(color: Colors.white),),
            space10Vertical,
            Text(' 2 - is Social Green Design',style:TextStyle(color: Colors.white),),
            const Spacer(),
            Container(
              decoration: const BoxDecoration(
                  color: Color(0xFF2B2B2D),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: artboards.map<Widget>((artboard) {
                    final index = artboards.indexOf(artboard);
                    return BottomAppBarItem(
                      artboard: artboard,
                      currentIndex: currentActiveIndex,
                      tabIndex: index,
                      input: inputs[index],
                      onpress: () {
                        setState(() {
                          currentActiveIndex = index;
                          if (currentActiveIndex == 1) {
                            Future.delayed(Duration(seconds: 1)).then((value) {
                              navigateTo(context, SocialIconPage());
                            });
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class BottomAppBarItem extends StatelessWidget {
  const BottomAppBarItem({
    Key? key,
    required this.artboard,
    required this.onpress,
    required this.currentIndex,
    required this.tabIndex,
    required this.input,
  }) : super(key: key);
  final Artboard? artboard;
  final VoidCallback onpress;
  final int currentIndex;
  final int tabIndex;
  final SMIInput<bool>? input;

  @override
  Widget build(BuildContext context) {
    if (input != null) {
      input!.value = currentIndex == tabIndex;
    }
    return SizedBox(
      width: 50,
      height: 50,
      child: GestureDetector(
        onTap: onpress,
        child: artboard == null ? const SizedBox() : Rive(artboard: artboard!),
      ),
    );
  }
}
