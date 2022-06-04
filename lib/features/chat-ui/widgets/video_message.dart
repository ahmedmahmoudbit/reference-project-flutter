import 'package:flutter/material.dart';
import 'package:reference_project_flutter/features/chat-ui/constants/constantChat.dart';

class VideoMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3, // 45% of total width
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network("https://images.unsplash.com/photo-1654244458346-bb6db7df0f15?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80"),
            ),
            Container(
              height: 25,
              width: 25,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                size: 16,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
