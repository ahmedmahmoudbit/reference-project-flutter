import 'package:flutter/material.dart';
import 'package:reference_project_flutter/features/chat-ui/constants/constantChat.dart';
import 'package:reference_project_flutter/features/chat-ui/models/demeChatMessages.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(message!.isSender ? 0.8 : 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message!.text,
          style: TextStyle(
            color: message!.isSender
                ? Colors.white
                : Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
      ),
    );
  }
}
