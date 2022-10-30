import 'package:flutter/material.dart';
import 'package:reference_project_flutter/core/constants.dart';
import 'package:reference_project_flutter/features/Social/SocialPage.dart';
import 'package:reference_project_flutter/features/blog_app/screen/mainPage.dart';
import 'package:reference_project_flutter/features/chat-ui/chatPage.dart';
import 'animation_playlist/main_page.dart';
import 'local_sound/playlist_page.dart';
import 'moviess/pages/movies_page/movies_page.dart';
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
                navigateTo(context, const HomePageTodo());
              },
              child: const Text('Todo')),
          TextButton(
              onPressed: () {
                navigateTo(context, const ChatPage());
              },
              child: const Text('Chat Ui')),
              TextButton(
                  onPressed: () {
                    navigateTo(context, const SocialPAge());
                  },
                  child: const Text('Social')),
              TextButton(
                  onPressed: () {
                    navigateTo(context, const MainPageBlog());
                  },
                  child: const Text('Blog Ui')),
              TextButton(
                  onPressed: () {
                    navigateTo(context, const MoviesPage());
                  },
                  child: const Text('Move Ui')),
              TextButton(
                  onPressed: () {
                    navigateTo(context, const PlaylistPage());
                  },
                  child: const Text('Local sound')),
              TextButton(
                  onPressed: () {
                    navigateTo(context, const LibraryPage());
                  },
                  child: const Text('Animation playlist')),
        ]),
      ),
    );
  }
}
