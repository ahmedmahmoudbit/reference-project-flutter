class Chat {
  final String name, lastMessage, image, time;
  final bool isActive;

  Chat({
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
  });
}

List chatsData = [
  Chat(
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "https://images.unsplash.com/photo-1654244458346-bb6db7df0f15?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "https://images.unsplash.com/photo-1654244458346-bb6db7df0f15?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "https://images.unsplash.com/photo-1654244458346-bb6db7df0f15?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
    time: "5d ago",
    isActive: false,
  ),
  Chat(
    name: "Jacob Jones",
    lastMessage: "You’re welcome :)",
    image: "https://images.unsplash.com/photo-1654244458346-bb6db7df0f15?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
    time: "5d ago",
    isActive: true,
  ),
  Chat(
    name: "Albert Flores",
    lastMessage: "Thanks",
    image: "https://images.unsplash.com/photo-1654244458346-bb6db7df0f15?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
    time: "6d ago",
    isActive: false,
  ),
  Chat(
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "https://images.unsplash.com/photo-1654244458346-bb6db7df0f15?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "https://images.unsplash.com/photo-1654244458346-bb6db7df0f15?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "https://images.unsplash.com/photo-1654244458346-bb6db7df0f15?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
    time: "5d ago",
    isActive: false,
  ),
];