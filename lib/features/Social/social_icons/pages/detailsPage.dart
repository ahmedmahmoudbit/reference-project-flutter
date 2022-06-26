import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reference_project_flutter/features/Social/social_icons/models/dataSocial.dart';

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

const TextStyle headline3 =
TextStyle(color:white,fontSize: 16, fontWeight: FontWeight.bold);

const TextStyle headline4 = TextStyle(
  fontSize: 14.0,
  color: white,
  fontWeight: FontWeight.w400,
);


class DetailsPage extends StatefulWidget {
  final SocialModel social;
  const DetailsPage({Key? key, required this.social}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int selectImage = 0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: black,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: height,
            color: green,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: height / 1.5,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(200.0),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 30.0,
              width: 30.0,
              margin: EdgeInsets.only(right: 10.0, top: 20.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: green,
              ),
              child: Icon(
                Icons.favorite_border_outlined,
                color: white,
                size: 18.0,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  height: height / 2.2,
                  child: PageView(
                    physics: BouncingScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        selectImage = index;
                      });
                    },
                    children: [
                      for (int i = 0; i < widget.social.images.length; i++)
                        Image.asset(
                          widget.social.images[i],
                          height: height / 2.2,
                        )
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100.0,
                      child: Column(
                        children: [
                          for (int k = 0; k < widget.social.images.length; k++)
                            Container(
                              margin: EdgeInsets.only(bottom: 5.0),
                              height: k == selectImage ? 20.0 : 6.0,
                              width: 6,
                              decoration: BoxDecoration(
                                color: k == selectImage
                                    ? green
                                    : green.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.social.name,
                            style: headline1,
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            widget.social.description,
                            maxLines: 2,
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.social.price,
                                style: headline2,
                              ),
                              SizedBox(width: 20.0),
                              Container(
                                height: 20.0,
                                width: 20.0,
                                decoration: BoxDecoration(
                                  color: white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.3),
                                      blurRadius: 10.0,
                                      offset: Offset(1, 6),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 10,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bottomTag(
                    headingText: 'Height',
                    image: 'height.svg',
                    text: widget.social.height,
                  ),
                  bottomTag(
                    headingText: 'Temperature',
                    image: 'celsius.svg',
                    text: widget.social.temp,
                  ),
                  bottomTag(
                    headingText: 'Pot',
                    image: 'social-pot.svg',
                    text: widget.social.pot,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomTag({
    required String text,
    required String image,
    required String headingText,
  }) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icon/$image',
          height: 30.0,
          color: white,
        ),
        SizedBox(height: 15.0),
        Text(
          headingText,
          style: headline3,
        ),
        SizedBox(height: 5.0),
        Text(
          text,
          style: headline4,
        ),
      ],
    );
  }
}
