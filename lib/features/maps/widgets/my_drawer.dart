import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  Widget buildDrawerHeader(context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(70, 10, 70, 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue[100],
          ),
          child: Image.asset(
            'assets/images/omar.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Text(
          'Omar Ahmed',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget buildDrawerListItem(
      {required IconData leadingIcon,
        required String title,
        Widget? trailing,
        Function()? onTap,
        Color? color}) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: color ?? Colors.blue,
      ),
      title: Text(title),
      trailing: trailing ??= Icon(
        Icons.arrow_right,
        color: Colors.blue,
      ),
      onTap: onTap,
    );
  }

  Widget buildDrawerListItemsDivider() {
    return Divider(
      height: 0,
      thickness: 1,
      indent: 18,
      endIndent: 24,
    );
  }

  // void _launchURL(String url) async {
  //   await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  // }

  Widget buildIcon(IconData icon, String url) {
    return InkWell(
      // onTap: () => _launchURL(url),
      onTap: () => print('url'),
      child: Icon(
        icon,
        color: Colors.blue,
        size: 35,
      ),
    );
  }

  Widget buildSocialMediaIcons() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16),
      child: Row(
        children: [
          buildIcon(
            Icons.facebook,
            'https://www.facebook.com/groups/omarahmedx14',
          ),
          const SizedBox(
            width: 15,
          ),
          buildIcon(
            Icons.youtube_searched_for,
            'https://www.youtube.com/c/OmarAhmedx14/videos',
          ),
          const SizedBox(
            width: 20,
          ),
          buildIcon(
            Icons.telegram,
            'https://t.me/OmarX14',
          ),
        ],
      ),
    );
  }

  Widget buildLogoutBlocProvider(context) {
    return Container(
        child: buildDrawerListItem(
          leadingIcon: Icons.logout,
          title: 'Logout',
          onTap: () async {
            // await phoneAuthCubit.logOut();
            // Navigator.of(context).pushReplacementNamed(loginScreen);
          },
          color: Colors.red,
          trailing: SizedBox(),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 280,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[100]),
              child: buildDrawerHeader(context),
            ),
          ),
          buildDrawerListItem(leadingIcon: Icons.person, title: 'My Profile'),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(
            leadingIcon: Icons.history,
            title: 'Places History',
            onTap: () {},
          ),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(leadingIcon: Icons.settings, title: 'Settings'),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(leadingIcon: Icons.help, title: 'Help'),
          buildDrawerListItemsDivider(),
          buildLogoutBlocProvider(context),
          const SizedBox(
            height: 180,
          ),
          ListTile(
            leading: Text(
              'Follow us',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          buildSocialMediaIcons(),
        ],
      ),
    );
  }
}