import 'package:flutter/material.dart';
import 'package:reference_project_flutter/features/chat-ui/MessagesScreen.dart';
import 'package:reference_project_flutter/features/chat-ui/chat_card.dart';
import 'package:reference_project_flutter/features/chat-ui/constants/constantChat.dart';
import 'package:reference_project_flutter/features/chat-ui/fillOutlineButton.dart';
import 'package:reference_project_flutter/features/chat-ui/models/chat_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(
                kDefaultPadding, 10, kDefaultPadding, kDefaultPadding),
            color: kPrimaryColor,
            child: Row(
              children: [
                FillOutlineButton(press: () {}, text: "Recent Message"),
                const SizedBox(width: kDefaultPadding),
                FillOutlineButton(
                  press: () {},
                  text: "Active",
                  isFilled: false,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatsData.length,
              itemBuilder: (context, index) => ChatCard(
                chat: chatsData[index],
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessagesScreen(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: kPrimaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.3),
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 14,
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1654244458346-bb6db7df0f15?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80"),
          ),
          label: "Profile",
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false,
      title: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          "Chats",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }
}
