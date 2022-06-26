import 'package:flutter/material.dart';
import 'package:reference_project_flutter/features/Social/social_icons/models/dataSocial.dart';
import 'package:reference_project_flutter/features/Social/social_icons/pages/detailsPage.dart';

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
TextStyle(color:white,fontSize: 16, fontWeight: FontWeight.bold);


class SocialItemCard extends StatelessWidget {
  final SocialModel social;
  const SocialItemCard({Key? key, required this.social}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (builder) => DetailsPage(social: social)));
      },
      child: Container(
        height: 400.0,
        margin: EdgeInsets.only(right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              social.images[0],
              height: 250.0,
            ),
            SizedBox(height: 20.0),
            Text(
              social.name,
              style: headline2,
            ),
            SizedBox(height: 5.0),
            Text(
              social.description,
              maxLines: 2,
            ),
            SizedBox(height: 20.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  social.price,
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
                    size: 10.0,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
