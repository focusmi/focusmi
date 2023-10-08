import 'package:focusmi/models/chat_message.dart';

class ChatRoomServices {
  static Future getChats() async {
    List<ChatMessage> messages = [
      ChatMessage(message_text: "Hello", message_type: "text", user_id: 1),
      ChatMessage(message_text: "Hello", message_type: "text", user_id: 2),
      ChatMessage(message_text: "Hi", message_type: "text", user_id: 3),
      ChatMessage(
          message_text: "How the work going on",
          message_type: "text",
          user_id: 1),
      ChatMessage(
          message_text: "I have done nothig", message_type: "text", user_id: 2),
      ChatMessage(
          message_text: "You know nothing Jon Snow",
          message_type: "text",
          user_id: 3),
      ChatMessage(message_text: "Bugger off", message_type: "text", user_id: 5),
    ];
    return messages;
  }
}
