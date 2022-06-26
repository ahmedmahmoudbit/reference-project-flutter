import 'package:flutter/material.dart';
import 'package:reference_project_flutter/core/constants.dart';
import 'package:reference_project_flutter/features/Social/SocialPage.dart';
import 'package:reference_project_flutter/features/chat-ui/chatPage.dart';

import 'todo/ui/home/HomePageTodo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          TextButton(
              onPressed: () {
                navigateTo(context, HomePageTodo());
              },
              child: Text('Todo')),
          TextButton(
              onPressed: () {
                navigateTo(context, ChatPage());
              },
              child: Text('Chat Ui')),
              TextButton(
                  onPressed: () {
                    navigateTo(context, SocialPAge());
                  },
                  child: Text('Social')),
        ]),
      ),
    );
  }
}
