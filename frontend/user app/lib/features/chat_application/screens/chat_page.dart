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

//   void getChatMessages() async {
//     try {
//       var result = await ChatPageServices.getChatMessage(widget.group_id);
//       Iterable list = json.decode(result.body).cast<Map<String?, dynamic>>();
//       messages = list.map((model) => ChatMessage.fromJson(model)).toList();
//       setState(() {
//         messages = messages;
//       });
//     } catch (e) {}
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
//           Container(
//             child: ListView.builder(
//               itemCount: messages.length,
//               shrinkWrap: true,
//               padding: EdgeInsets.only(top: 10, bottom: 10),
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return Container(
//                   padding:
//                       EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
//                   child: Align(
//                     alignment: (messages[index].user_id == user_id
//                         ? Alignment.topLeft
//                         : Alignment.topRight),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: (messages[index].user_id == user_id
//                             ? Colors.grey.shade200
//                             : Colors.blue[200]),
//                       ),
//                       padding: EdgeInsets.all(16),
//                       child: Text(
//                         messages[index].message_text,
//                         style: TextStyle(fontSize: 15),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
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
import 'package:web_socket_channel/io.dart';

class ChatPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return ChatPageState();
  }
}

class ChatPageState extends State<ChatPage>{
  

  late IOWebSocketChannel channel; //channel varaible for websocket
  late bool connected; // boolean value to track connection status

  String myid = "222"; //my id
  String recieverid = "111"; //reciever id
  // swap myid and recieverid value on another mobile to test send and recieve
  String auth = "chatapphdfgjd34534hjdfk"; //auth key

  List<MessageData> msglist = [];

  TextEditingController msgtext = TextEditingController();
  @override
  void initState() {
    connected = false;
    msgtext.text = "";
    channelconnect();
    super.initState();
  }

  channelconnect(){ //function to connect 
    try{
         channel = IOWebSocketChannel.connect("ws://192.168.222.55:6060/$myid"); //channel IP : Port
         channel.stream.listen((message) {
            print(message);
            setState(() {
                 if(message == "connected"){
                      connected = true;
                      setState(() { });
                      print("Connection establised.");
                 }else if(message == "send:success"){
                      print("Message send success");
                      setState(() {
                        msgtext.text = "";
                      });
                 }else if(message == "send:error"){
                     print("Message send error");
                 }else if (message.substring(0, 6) == "{'cmd'") {
                     print("Message data");
                     message = message.replaceAll(RegExp("'"), '"');
                     var jsondata = json.decode(message);

                       msglist.add(MessageData( //on message recieve, add data to model
                              msgtext: jsondata["msgtext"],
                              userid: jsondata["userid"],
                              isme: false,
                          )
                       );
                    setState(() { //update UI after adding data to message model
      
                    });
                 }
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
        },);
    }catch (_){
      print("error on connecting to websocket.");
    }
  }

  Future<void> sendmsg(String sendmsg, String id) async {
         if(connected == true){
            String msg = "{'auth':'$auth','cmd':'send','userid':'$id', 'msgtext':'$sendmsg'}";
            setState(() {
               msgtext.text = "";
               msglist.add(MessageData(msgtext: sendmsg, userid: myid, isme: true));
            });
            channel.sink.add(msg); //send message to reciever channel
         }else{
            channelconnect();
            print("Websocket is not connected.");
         }
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar( 
          title: Text("My ID: $myid - Chat App Example"),
          leading: Icon(Icons.circle, color: connected?Colors.greenAccent:Colors.redAccent),
          //if app is connected to node.js then it will be gree, else red.
          titleSpacing: 0,
        ),
        body: Container( 
           child: Stack(children: [
               Positioned( 
                  top:0,bottom:70,left:0, right:0,
                  child:Container( 
                    padding: EdgeInsets.all(15),
                    child: SingleChildScrollView( 
                      child:Column(children: [

                            Container( 
                              child:Text("Your Messages", style: TextStyle(fontSize: 20)),
                            ),

                            Container( 
                              child: Column( 
                                children: msglist.map((onemsg){
                                  return Container( 
                                     margin: EdgeInsets.only( //if is my message, then it has margin 40 at left
                                             left: onemsg.isme?40:0,
                                             right: onemsg.isme?0:40, //else margin at right
                                          ),
                                     child: Card( 
                                        color: onemsg.isme?Colors.blue[100]:Colors.red[100],
                                        //if its my message then, blue background else red background
                                        child: Container( 
                                          width: double.infinity,
                                          padding: EdgeInsets.all(15),
                                          
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Container(
                                                child:Text(onemsg.isme?"ID: ME":"ID: " + onemsg.userid)
                                              ),

                                              Container( 
                                                 margin: EdgeInsets.only(top:10,bottom:10),
                                                 child: Text("Message: " + onemsg.msgtext, style: TextStyle(fontSize: 17)),
                                              ),
                                                
                                            ],),
                                        )
                                     )
                                  );
                                }).toList(),
                              )
                            )
                       ],)
                    )
                  )
               ),

               Positioned(  //position text field at bottom of screen
               
                 bottom: 0, left:0, right:0,
                 child: Container( 
                      color: Colors.black12,
                      height: 70,
                      child: Row(children: [
                          
                          Expanded(
                            child: Container( 
                              margin: EdgeInsets.all(10),
                              child: TextField(
                                  controller: msgtext,
                                  decoration: InputDecoration( 
                                    hintText: "Enter your Message"
                                  ),
                              ),
                            )
                          ),

                          Container(
                            margin: EdgeInsets.all(10),
                            child: ElevatedButton( 
                              child:Icon(Icons.send),
                              onPressed: (){
                                if(msgtext.text != ""){
                                  sendmsg(msgtext.text, recieverid); //send message with webspcket
                                }else{
                                  print("Enter message");
                                }
                              },
                            )
                          )
                      ],)
                    ),
               )
           ],)
        )
     );
  }
}

class MessageData{ //message data model
    String msgtext, userid;
    bool isme;
    MessageData({required this.msgtext, required this.userid, required this.isme});
     
}
