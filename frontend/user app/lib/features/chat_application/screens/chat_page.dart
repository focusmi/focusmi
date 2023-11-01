// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// import 'package:focusmi/constants/global_variables.dart';
// import 'package:focusmi/features/chat_application/services/chat_room_services.dart';
// import 'package:focusmi/models/chat_message.dart';
// import 'package:focusmi/providers/user_provider.dart';

// class ChatPage extends StatefulWidget {
//   int group_id;
//   ChatPage({
//     Key? key,
//     required this.group_id,
//   }) : super(key: key);
//   static const String routeName = '/chat_page';
//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   late List<ChatMessage> messages;
//   late TextEditingController messageInputController;
//   late int user_id;
//   late IO.Socket socket;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     socket = IO.io(
//         uri,
//         IO.OptionBuilder()
//             .setTransports(['websocket']) // for Flutter or Dart VM
//             .disableAutoConnect() // disable auto-connection // optional
//             .build());
//     socket.connect();
//     user_id = Provider.of<UserProvider>(context, listen: false).user.user_id;
//     messages = [];
//     getChatMessages();
//     messageInputController = TextEditingController();
//     setUpSocketListener();

//   }

//   void setUpSocketListener() {
//     print("initiailized");
//     socket.on("messageback", (data) {
//       print("------------listenening and recieved-----------------");
//       print(data);
//     });
//   }

//   void sendMessage() {
//     try {
//       var user = Provider.of<UserProvider>(context, listen: false).user;
//       ChatMessage chatMessage = ChatMessage(
//           message_text: messageInputController.text,
//           message_type: "text",
//           user_id: user.user_id,
//           group_id: widget.group_id,
//           image: null);

//       //socket.emit('message', chatMessage.toJson());
//       socket.emit("message", chatMessage);
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         flexibleSpace: SafeArea(
//           child: Container(
//             padding: EdgeInsets.only(right: 16),
//             child: Row(
//               children: <Widget>[
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 2,
//                 ),
//                 CircleAvatar(
//                   // backgroundImage: NetworkImage(
//                   //     "<https://randomuser.me/api/portraits/men/5.jpg>"),
//                   maxRadius: 20,
//                 ),
//                 SizedBox(
//                   width: 12,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         "Kriss Benwat",
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w600),
//                       ),
//                       SizedBox(
//                         height: 6,
//                       ),
//                       Text(
//                         "Online",
//                         style: TextStyle(
//                             color: Colors.grey.shade600, fontSize: 13),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(
//                   Icons.settings,
//                   color: Colors.black54,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: <Widget>[
// Container(
//   child: ListView.builder(
//     itemCount: messages.length,
//     shrinkWrap: true,
//     padding: EdgeInsets.only(top: 10, bottom: 10),
//     physics: NeverScrollableScrollPhysics(),
//     itemBuilder: (context, index) {
//       return
//     },
//   ),
//           ),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Container(
//               padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
//               height: 60,
//               width: double.infinity,
//               color: Colors.white,
//               child: Row(
//                 children: <Widget>[
//                   GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         color: Colors.lightBlue,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Icon(
//                         Icons.add,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Expanded(
//                     child: TextField(
//                       controller: messageInputController,
//                       decoration: InputDecoration(
//                           hintText: "Write message...",
//                           hintStyle: TextStyle(color: Colors.black54),
//                           border: InputBorder.none),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   FloatingActionButton(
//                     onPressed: () {
//                       sendMessage();
//                       messageInputController.text = "";
//                     },
//                     child: Icon(
//                       Icons.send,
//                       color: Colors.white,
//                       size: 18,
//                     ),
//                     backgroundColor: Colors.blue,
//                     elevation: 0,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:focusmi/features/chat_application/services/chat_room_services.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';

import 'package:focusmi/features/group_task_planner/services/group_task_planner_services.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/models/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  late int groupid;
  ChatPage({
    Key? key,
    required this.groupid,
  }) : super(key: key);
  State<StatefulWidget> createState() {
    return ChatPageState();
  }
}

class ChatPageState extends State<ChatPage> {
  late IOWebSocketChannel channel; //channel varaible for websocket
  late bool connected; // boolean value to track connection status

  String myid = "222"; //my id
  String recieverid = "111"; //reciever id
  // swap myid and recieverid value on another mobile to test send and recieve
  String auth = "chatapphdfgjd34534hjdfk"; //auth key
  late int chatid;
  List<ChatMessage> msglist = [];

  TextEditingController msgtext = TextEditingController();
  @override
  void initState() {
    connected = false;
    msgtext.text = "";
    chatid = 0;
    getChat();
    getChatMessages();
    super.initState();
  }

  void getChatMessages() async {
    try {
      var result = await ChatRoomServices.getChatMessage(widget.groupid);
      Iterable list = json.decode(result.body).cast<Map<String?, dynamic>>();
      var message = list.map((model) => ChatMessage.fromJson(model)).toList();
      setState(() {
        msglist = message;
      });
    } catch (e) {}
  }

  getChat() async {
    try {
      var result = await GTaskPlannerServices.getChatByGroup(widget.groupid);
      setState(() {
        chatid = json.decode(result.body)[0];
        
      });
      channelconnect(chatid);
    } catch (e) {
      print(e);
    }
  }

  channelconnect(ch) {
    //function to connect
    try {
      connected = true;
      channel = IOWebSocketChannel.connect("ws://192.168.222.55:6060/$ch" +
          "-" +
          Provider.of<UserProvider>(context, listen: false)
              .user
              .user_id
              .toString()); //channel IP : Port
      channel.stream.listen(
        (message) {
          setState(() {
            var jsondata = message.split("-");
            msglist.add(ChatMessage(
              user_id: int.parse(jsondata[1]),
              //on message recieve, add data to model
              message_text: jsondata[2],
              message_type: "text",

              chat_id: int.parse(jsondata[0]),
            ));
            setState(() {
              //update UI after adding data to message model
            });
          });
        },
        onDone: () {
          //if WebSocket is disconnected
          print("Web socket is closed");
          setState(() {
            connected = false;
          });
        },
        onError: (error) {
          print(error.toString());
        },
      );
    } catch (_) {
      print("error on connecting to websocket.");
    }
  }

  Future<void> sendmsg(String sendmsg, String id) async {
    var result = await GTaskPlannerServices.getChatByGroup(widget.groupid);

    int chatid = json.decode(result.body)[0];

    if (connected == true) {
      String msg = sendmsg;
      int user = Provider.of<UserProvider>(context, listen: false).user.user_id;
      setState(() {
        msgtext.text = "";
        msglist.add(ChatMessage(
          message_text: msg,
          message_type: "text",
          user_id: user,
          chat_id: chatid,
        ));
      });
      print("//////////////");
      print("{'user_id':'" +
          user.toString() +
          "','chat_id':'" +
          chatid.toString() +
          "', 'message_text':'" +
          msg +
          "'}");
      print("//////////////");
      channel.sink.add("{'user_id':'" +
          user.toString() +
          "','chat_id':'" +
          chatid.toString() +
          "', 'message_text':'" +
          msg +
          "'}");
    } else {
      getChat();
      print("Websocket is not connected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    LayOut layOut = LayOut();
    int user = Provider.of<UserProvider>(context, listen: false).user.user_id;
    return layOut.mainLayoutWithDrawer(
        context,
        Container(
            child: Stack(
          children: [
            Positioned(
                top: 0,
                bottom: 70,
                left: 0,
                right: 0,
                child: Container(
                    padding: EdgeInsets.all(15),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Container(
                            child: Column(
                          children: msglist.map((onemsg) {
                            return Container(
                                child: Container(
                              padding: EdgeInsets.only(
                                  left: 14, right: 14, top: 10, bottom: 10),
                              child: Align(
                                alignment: (onemsg.user_id == user
                                    ? Alignment.topLeft
                                    : Alignment.topRight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (onemsg.user_id == user
                                        ? Colors.grey.shade200
                                        : Colors.blue[200]),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    onemsg.message_text,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            ));
                          }).toList(),
                        ))
                      ],
                    )))),
            Positioned(
              //position text field at bottom of screen

              bottom: 0, left: 0, right: 0,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              controller: msgtext,
                              decoration: InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              if (msgtext.text != "") {
                                sendmsg(msgtext.text,
                                    recieverid); //send message with webspcket
                              } else {
                                print("Enter message");
                              }
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                            backgroundColor: Colors.blue,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
        "Group Chat");
  }
}

// class MessageData{ //message data model
//     String msgtext, userid;
//     bool isme;
//     MessageData({required this.msgtext, required this.userid, required this.isme});

// }
