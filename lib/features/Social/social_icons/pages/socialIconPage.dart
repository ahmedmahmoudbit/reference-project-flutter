import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reference_project_flutter/features/Social/social_icons/models/dataSocial.dart';
import 'package:reference_project_flutter/features/Social/social_icons/widgets/card.dart';
import 'package:reference_project_flutter/features/Social/social_icons/widgets/customAppbar.dart';
import 'package:reference_project_flutter/features/Social/social_icons/widgets/menuBar.dart';

// colors ---
const Color green = Color(0xff76984b);
const Color white = Color(0xffffffff);
const Color black = Color(0xff000000);

// textStyles ---
const TextStyle button =
    TextStyle(color: white, fontSize: 16.0, fontWeight: FontWeight.w600);

const TextStyle headline1 =
    TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);

const TextStyle headline2 =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

const TextStyle headline6 =
    TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.bold);

class SocialIconPage extends StatefulWidget {
  const SocialIconPage({Key? key}) : super(key: key);

  @override
  State<SocialIconPage> createState() => _SocialIconPageState();
}

class _SocialIconPageState extends State<SocialIconPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]); // to hide only bottom bar
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Stack(
            children: [
              Row(
                children: [
                  MenuBar(),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 50, left: 35.0, right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Socal'),
                          Text(
                            'different SocalMedia',
                            style: headline1,
                          ),
                          Expanded(
                            child: Scrollbar(
                              thickness: 4,
                              child: ListView.builder(
                                itemCount: socialData.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (itemBuilder, index) {
                                  final plant = socialData[index];
                                  return SocialItemCard(
                                    social: plant,
                                  );
                                },
                              ),
                            ),
                          ),
                          // CustomAppBar(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              CustomAppBar(),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextButton(
                    onPressed: () {},
                    child: SvgPicture.asset(
                      'assets/icon/home.svg',
                      height: 25.0,
                      color: white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
